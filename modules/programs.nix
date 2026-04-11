{ pkgs, inputs, ... }:

{
    imports = [
        inputs.zen-browser.homeModules.twilight
    ];

    programs.zen-browser.enable = true;

    home.packages = with pkgs; [
        kdePackages.kate
        gh
        obsidian
        vim

        # Hyprland
        hyprshot
    ];
}
