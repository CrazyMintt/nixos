{ pkgs, inputs, ... }:

let
  spicetify = inputs.spicetify-nix.lib.mkSpicetify pkgs {
  };
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in 

{
    imports = [
        inputs.zen-browser.homeModules.twilight
        inputs.spicetify-nix.homeManagerModules.spicetify
    ];

    programs.zen-browser.enable = true;

    programs.spicetify = {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        ];
    };

    programs.yazi = {
        enable = true;
        shellWrapperName = "y";
    };

    home.packages = with pkgs; [
        gh

        # --- Code ---
        vscode

        # --- Notes ---
        obsidian

        # --- Hyprland ---
        bibata-cursors
        hyprshot

        # --- File Picker ---
        nautilus
    ];
}
