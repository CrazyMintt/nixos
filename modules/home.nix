# Home Manager configuration
{ config, pkgs, inputs, hyprlandConfig, vars, ... }:

{
  home.username = "bruno";
  home.homeDirectory = "/home/bruno";
  home.stateVersion = "25.11";

  imports = [
    ./programs.nix
    ./desktop-shells/noctalia.nix
    ./shell.nix
    hyprlandConfig
    ./theme.nix
  ];

  home.sessionVariables = {
    BROWSER = vars.browser;
    DEFAULT_BROWSER = vars.browser;
    TERMINAL = vars.terminal;
    EDITOR = vars.editor;
  };

  # Add home-manager packages
  home.packages = with pkgs; [
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
