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
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... }@inputs:
    let
      system = "x86_64-linux";

      mkSystem = hostModules: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./modules/system.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bruno = import ./modules/home.nix;
            home-manager.backupFileExtension = "bkp";
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ] ++ hostModules;
      };
    in
    {
      nixosConfigurations = {
        notebook = mkSystem [
          ./modules/notebook.nix
          ./modules/hosts/notebook/hardware-configuration.nix
        ];

        desktop = mkSystem [
          ./modules/desktop.nix
          ./modules/gaming.nix
          ./modules/hosts/desktop/hardware-configuration.nix
        ];
      };
    };
}