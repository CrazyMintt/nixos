{ lib, gui ? true, ... }:

let
  shellAliases = {
    cat = "bat";
    dpl = "nix run github:serokell/deploy-rs --";
    gsu = "git submodule update --remote";
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    ncg = "sudo nix-collect-garbage -d";
    vw = "vim ~/.Tenjin/index.md";
  } // lib.optionalAttrs gui {
    dev = "devenv shell -- zeditor . && exit";
    ssh = "kitty +kitten ssh";
    zed = "zeditor";
    zen-browser = "zen-twilight";
  };
in

{
  programs.kitty = lib.mkIf gui {
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