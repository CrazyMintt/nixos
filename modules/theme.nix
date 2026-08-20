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

    fonts.fontconfig.defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      serif = [ "JetBrainsMono Nerd Font" ];
      sansSerif = [ "JetBrainsMono Nerd Font" ];
    };

    # Mouse pointer cursor theme
    home.pointerCursor = {
        enable = true;
        gtk.enable = true;
        x11.enable = true;

        package = pkgs.bibata-cursors;

        name = vars.cursorTheme;
        size = vars.cursorSize;
  };

  home.packages = with pkgs; [
    # --- Font ---
    nerd-fonts.jetbrains-mono
  ];
}