# Home Manager configuration
{ config, lib, pkgs, vars, gui ? true, hyprlandConfig ? null, ... }:

{
  home.username = "bruno";
  home.homeDirectory = "/home/bruno";
  home.stateVersion = "25.11";

  imports = [
    ./shell.nix
    ./programs/vim.nix
  ]
  ++ lib.optionals gui [
    ./programs.nix
    ./desktop-shells/noctalia.nix
    ./theme.nix
  ]
  ++ lib.optionals (hyprlandConfig != null) [
    hyprlandConfig
  ];

  home.sessionVariables = {
    BROWSER = vars.browser;
    DEFAULT_BROWSER = vars.browser;
    TERMINAL = vars.terminal;
    EDITOR = vars.editor;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Bruno";
        email = "manobrunodutra@gmail.com";
      };
    };
  };

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };

  programs.fish.enable = true;

  programs.home-manager.enable = true;
}
