# Home Manager configuration
{ config, pkgs, inputs, ... }:

{
  home.username = "bruno";
  home.homeDirectory = "/home/bruno";
  home.stateVersion = "25.11";

  imports = [
    ./programs.nix
    ./desktop-shells/noctalia.nix
    ./shell.nix
    ./hyprland
  ];

  xdg.configFile."kdedefaults/kdeglobals".text = ''
    [General]
    TerminalApplication=kitty
  '';

  # Add home-manager packages
  home.packages = with pkgs; [
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
