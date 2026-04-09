# /etc/nixos/flake.nix
{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11-stable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      notebook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;

        modules = [
          ./modules/common.nix
          ./modules/notebook.nix
          ./hardware-configuration.nix
        ];
      };

      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;

        modules = [
          ./modules/common.nix
          ./modules/desktop.nix
	      ./hardware-configuration.nix
	      ./modules/gaming.nix
        ];
      };
    };
  };
}
