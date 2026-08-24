# Home Manager configuration
{ pkgs, hyprlandConfig, vars, ... }:

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

  home.packages = with pkgs; [
  ];

  programs.home-manager.enable = true;
}
