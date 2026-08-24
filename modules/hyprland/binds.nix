{ vars, ... }:
let
  mainMod = "SUPER";
  terminal = "${vars.terminal}";
  browser = "${vars.browser}";
  fileManager = "${vars.terminal} -e ${vars.file}";
  editor = "${vars.editor}";
in
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = mainMod;
    bind = [
      # Apps
      "$mainMod, T, exec, ${terminal}"
      "$mainMod SHIFT, T, exec, zeditor ~/.dotfiles"
      "$mainMod, K, exec, keepassxc"
      "$mainMod, E, exec, ${fileManager}"
      "$mainMod, W, exec, ${browser}"
      "$mainMod, O, exec, obsidian"
      "$mainMod, C, exec, ${editor}"
      "$mainMod, I, exec, noctalia msg settings-toggle"
      "$mainMod, BACKSPACE, exec, noctalia msg panel-toggle session"
      "$mainMod, L, exec, noctalia msg session lock"
      "CTRL SHIFT, Escape, exec, ${terminal} -e btop"

      # Windows
      "$mainMod, Q, killactive"
      "$mainMod, F, fullscreen"
      "$mainMod, D, fullscreen, 1"
      "$mainMod ALT, SPACE, togglefloating"

      # Workspaces
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"
      "$mainMod CTRL, right, workspace, r+1"
      "$mainMod CTRL, left, workspace, r-1"

      # Move to Workspace
      "$mainMod ALT, 1, movetoworkspace, 1"
      "$mainMod ALT, 2, movetoworkspace, 2"
      "$mainMod ALT, 3, movetoworkspace, 3"
      "$mainMod ALT, 4, movetoworkspace, 4"
      "$mainMod ALT, 5, movetoworkspace, 5"
      "$mainMod ALT, 6, movetoworkspace, 6"
      "$mainMod ALT, 7, movetoworkspace, 7"
      "$mainMod ALT, 8, movetoworkspace, 8"
      "$mainMod ALT, 9, movetoworkspace, 9"
      "$mainMod ALT, 0, movetoworkspace, 10"
      "$mainMod ALT, right, movetoworkspace, r+1"
      "$mainMod ALT, left, movetoworkspace, r-1"

      # Scratchpad
      "$mainMod, S, togglespecialworkspace, magic"
      "$mainMod ALT, S, movetoworkspace, special:magic"

      # Media Keys
      ", XF86MonBrightnessUp, exec, noctalia msg brightness-up"
      ", XF86MonBrightnessDown, exec, noctalia msg brightness-down"
      ", XF86AudioRaiseVolume, exec, noctalia msg volume-up"
      ", XF86AudioLowerVolume, exec, noctalia msg volume-down"
      ", XF86AudioMute, exec, noctalia msg volume-mute"
      ", XF86AudioPlay, exec, noctalia msg media toggle"
      ", XF86AudioNext, exec, noctalia msg next"
      ", XF86AudioPrev, exec, noctalia msg previous"
      ", XF86AudioMicMute, exec, noctalia msg mic-mute"

      # Extras
      "$mainMod, V, exec, noctalia msg panel-toggle clipboard"

      # Screenshots
      ", Print, exec, hyprshot -z -m output -m active -o ~/Pictures/Screenshots/"
      "$mainMod, Print, exec, hyprshot -z -m window -o ~/Pictures/Screenshots/"
      "$mainMod SHIFT, S, exec, hyprshot -z -m region -o ~/Pictures/Screenshots/"
    ];

    # Binds que repetem (bindr), binds de mouse (bindm), etc
    bindr = [
      "$mainMod, SUPER_L, exec, noctalia msg panel-toggle launcher"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
