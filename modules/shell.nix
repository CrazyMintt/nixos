let
  shellAliases = {
    cat = "bat";
    dev = "devenv shell -- zeditor . && exit";
    ssh = "kitty +kitten ssh";
    nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles";
    nrs-pi = "NIX_SSHOPTS=\"-i /home/bruno/.ssh/nix_rpi_server\" nixos-rebuild switch --flake ~/.dotfiles#nix-rpi-server --target-host root@nix-rpi-server";
    ncg = "sudo nix-collect-garbage -d";
    zed = "zeditor";
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