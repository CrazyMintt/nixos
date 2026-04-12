{ pkgs, vars, ... }:
{
  imports = [
    ./binds.nix
    ./hypridle.nix
    ./window-rules.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    # plugins = [ ... ];

    settings = {
      #################
      ### AUTOSTART ###
      #################
      exec-once = [
        "nm-applet &"
        "noctalia-shell &"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      #####################
      ### LOOK AND FEEL ###
      #####################
      general = {
        gaps_in = 5;
        gaps_out = 7;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        active_opacity = 1.0;
        inactive_opacity = 0.94;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
          "specialWorkspace, 1, 6, myBezier, slidevert"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        special_scale_factor = 0.9;
      };

      misc = {
        disable_hyprland_logo = true;
        allow_session_lock_restore = true;
      };

      #############
      ### INPUT ###
      #############
      input = {
        kb_layout = "br";
        kb_variant = "abnt2";
        numlock_by_default = true;
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      gesture = "3, horizontal, workspace";
    };
  };
}
