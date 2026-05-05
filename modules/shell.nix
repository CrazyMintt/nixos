{ pkgs, ... }:

let
  shellAliases = {
    cat = "bat";
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    ncg = "sudo nix-collect-garbage -d";
    zen-browser = "zen-twilight";
  };
in

{
    programs.kitty = {
        enable = true;
        extraConfig = "include $HOME/.config/kitty/themes/noctalia.conf";
        settings = {
            confirm_os_window_close = 0;
        };
    };

    programs.fish = {
        enable = true;
        interactiveShellInit = ''
        set fish_greeting # Disable greeting
        '';
        inherit shellAliases;
    };
}