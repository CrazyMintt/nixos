# /etc/nixos/flake.nix
{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-24-11.url = "github:NixOS/nixpkgs/nixos-24.11";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # --- Projects/Services ---
    site-matheus = {
      url = "git+https://github.com/CrazyMintt/SiteMatheus.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nerd-run = {
      url = "git+https://github.com/CrazyMintt/Nerd-run.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-24-11, home-manager, sops-nix, noctalia, ... }@inputs:
    let
      system = "x86_64-linux";
      userSettings = import ./variables.nix;

      mkSystem = hostName: hostModules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/system.nix
          ./modules/services
          ./modules/secrets/secrets.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bruno = import ./modules/home.nix;
            home-manager.backupFileExtension = "bkp";
            home-manager.extraSpecialArgs = {
              inherit inputs;
              vars = userSettings;
              hyprlandConfig = ./modules/hyprland/monitor/${hostName}-default.nix;
            };
          }
        ] ++ hostModules;
      };
    in
    {
      nixosConfigurations = {
        notebook = mkSystem "notebook" [
          ./modules/hosts/notebook/configuration.nix
          ./modules/hosts/notebook/hardware-configuration.nix
          ./modules/gaming.nix
        ];

        desktop = mkSystem "desktop" [
          ./modules/hosts/desktop/configuration.nix
          ./modules/hosts/desktop/hardware-configuration.nix
          ./modules/gaming.nix
        ];

        nix-rpi-server = nixpkgs-24-11.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.buildPlatform = "x86_64-linux";
              nixpkgs.hostPlatform = "armv6l-linux";
              sops.package = (import inputs.sops-nix {
                pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux.pkgsCross.raspberryPi;
              }).sops-install-secrets;
              sops.validationPackage = inputs.sops-nix.packages.x86_64-linux.sops-install-secrets;
            }
            ./modules/secrets/secrets.nix
            ./modules/services
            ./modules/hosts/nix-rpi-server/default.nix
          ];
        };
      };
    };
}
