# /etc/nixos/flake.nix
{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, noctalia, deploy-rs, ... }@inputs:
    let
      system = "x86_64-linux";
      userSettings = import ./variables.nix;

      mkSystem = { hostName, hostModules, gui ? true }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/system.nix
            { networking.hostName = hostName; }
          ] ++ nixpkgs.lib.optionals gui [
            ./modules/gui.nix
          ] ++ [
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.bruno = import ./modules/home.nix;
              home-manager.backupFileExtension = "bkp";
              home-manager.extraSpecialArgs = {
                inherit inputs gui;
                vars = userSettings;
                hyprlandConfig =
                  if gui then ./modules/hyprland/monitor/${hostName}-default.nix else null;
              };
            }
          ] ++ hostModules;
        };

      hosts = {
        notebook = {
          hostModules = [
            ./modules/hosts/notebook/configuration.nix
            ./modules/hosts/notebook/hardware-configuration.nix
            ./modules/gaming.nix
          ];
        };

        desktop = {
          hostModules = [
            ./modules/hosts/desktop/configuration.nix
            ./modules/hosts/desktop/hardware-configuration.nix
            ./modules/gaming.nix
          ];
        };

        server = {
          gui = false;
          hostModules = [
            ./modules/hosts/server/configuration.nix
            ./modules/hosts/server/hardware-configuration.nix
          ];
        };
      };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs (hostName: cfg: mkSystem {
        inherit hostName;
        hostModules = cfg.hostModules;
        gui = cfg.gui or true;
      }) hosts;

      deploy = {
        nodes.server = {
          hostname = "server";
          sshUser = "bruno";
          interactiveSudo = true;
          profiles.system = {
            user = "root";
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.server;
          };
        };
      };

      checks = builtins.mapAttrs
        (system: deployLib: deployLib.deployChecks self.deploy)
        deploy-rs.lib;
    };
}
