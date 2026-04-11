{ pkgs, ... }:

{
    programs.kitty = {
        enable = true;
        extraConfig = "include $HOME/.config/kitty/themes/noctalia.conf";
        settings = {
            confirm_os_window_close = 0;
        };
    };
}