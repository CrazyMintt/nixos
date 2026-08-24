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

    # --- Projects/Services ---
    site-matheus = {
      url = "git+https://github.com/CrazyMintt/SiteMatheus.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, noctalia, ... }@inputs:
    let
      system = "x86_64-linux";
      userSettings = import ./variables.nix;

      mkSystem = hostName: hostModules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/system.nix
          ./modules/services
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
      };
    };
}
