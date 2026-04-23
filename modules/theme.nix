{ pkgs, vars, ... }:

{
    dconf = {
        settings = {
            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
            };
        };
    };

    xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
            xdg-desktop-portal-gnome
            xdg-desktop-portal-gtk
        ];
        config = {
            hyprland = {
                "org.freedesktop.impl.portal.FileChooser" = [ "gnome" ];
            };
        };
    };

    # Mouse pointer cursor theme
    home.pointerCursor = {
        gtk.enable = true;
        x11.enable = true;

        package = pkgs.bibata-cursors;

        name = vars.cursorTheme;
        size = vars.cursorSize;
  };
}