{ config, inputs, ...}:

# illogical-flake = {
#   url = "github:soymou/illogical-flake";
#   inputs.nixpkgs.follows = "nixpkgs";
# };

{
    # Config do illogical
    imports = [
        inputs.illogical-flake.homeManagerModules.default
    ];

    programs.illogical-impulse = {
        enable = true;

        dotfiles = {
            fish.enable = true;
            kitty.enable = true;
            starship.enable = true;
        };
    };
}