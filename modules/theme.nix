{ pkgs, vars, ... }:

{
    # Mouse pointer cursor theme
    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;

        package = pkgs.bibata-cursors;

        name = vars.cursorTheme;
        size = vars.cursorSize;
  };
}