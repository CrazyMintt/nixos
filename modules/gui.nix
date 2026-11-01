# Graphical interface configuration (desktop hosts only)
{ inputs, pkgs, vars, ... }:

let
  fileManager = "${vars.terminal} -e ${vars.file}";
  vimwiki = "${vars.terminal} -e ${vars.vimwiki}";
in
{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [
      pkgs.kdePackages.qtmultimedia
    ];
  };

  imports = [ inputs.umbriel.nixosModules.default ];
  programs.umbriel.enable = true;
  
  home-manager.sharedModules = [ inputs.umbriel.homeModules.default ];

  home-manager.users.bruno.programs.umbriel = {
    enable = true;
    settings = {
      general = {
        show_cheatsheet = false;
        autostart = [
          "noctalia"
          "nm-applet"
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
        ];
      };
      layout = {
        gap = 5;
        mode = "dwindle";
        dwindle.new_toward_cursor = true;
      };
      input = {
        keyboard.layout = "br";
        focus.follows_mouse = true;
        touchpad.natural_scroll = true;
      };
      output = {
        eDP-1 = {
          workspaces = 10;
          workspace_axis = "horizontal";
        };
        DP-2 = {
          workspaces = 10;
          workspace_axis = "horizontal";
          mode = "1920x1080@144";
        };
      };
      appearance.border_width = 0;
      keybinds = {
        # --- Apps ---
        "Mod+T" = "spawn ${vars.terminal}";
        "Mod+E" = "spawn ${fileManager}";
        "Mod+Shift+V" = "spawn ${vimwiki}";
        "Mod+W" = "spawn ${vars.browser}";
        "Mod+C" = "spawn ${vars.guiEditor}";
        "Mod+Shift+C" = "spawn ${vars.guiEditor} ~/.dotfiles";
        "Mod+K" = "spawn keepassxc";
        "Mod+Y" = "spawn freetube";
        "Mod+O" = "spawn obsidian";
        "Ctrl+Shift+Escape" = "spawn ${vars.terminal} -e btop";

        # --- Noctalia ---
        "Mod+I" = "spawn noctalia msg settings-toggle";
        "Mod+L" = "spawn noctalia msg session lock";
        "Mod+Backspace" = "spawn noctalia msg panel-toggle session";
        "Mod" = "spawn noctalia msg panel-toggle launcher";

        # --- Window ---
        "Mod+Q" = "window-close";
        "Mod+D" = "window-toggle-maximize-to-edges";
        "Mod+F" = "window-toggle-fullscreen";

        # --- Workspace ---
        "Mod+1" = "workspace-switch 1";
        "Mod+2" = "workspace-switch 2";
        "Mod+3" = "workspace-switch 3";
        "Mod+4" = "workspace-switch 4";
        "Mod+5" = "workspace-switch 5";
        "Mod+6" = "workspace-switch 6";
        "Mod+7" = "workspace-switch 7";
        "Mod+8" = "workspace-switch 8";
        "Mod+9" = "workspace-switch 9";
        "Mod+0" = "workspace-switch 10";

        "Mod+Alt+1" = "window-move-to-workspace 1";
        "Mod+Alt+2" = "window-move-to-workspace 2";
        "Mod+Alt+3" = "window-move-to-workspace 3";
        "Mod+Alt+4" = "window-move-to-workspace 4";
        "Mod+Alt+5" = "window-move-to-workspace 5";
        "Mod+Alt+6" = "window-move-to-workspace 6";
        "Mod+Alt+7" = "window-move-to-workspace 7";
        "Mod+Alt+8" = "window-move-to-workspace 8";
        "Mod+Alt+9" = "window-move-to-workspace 9";
        "Mod+Alt+0" = "window-move-to-workspace 10";

        # --- Scrathpad ---
        "Mod+S" = "scratchpad-toggle";
        "Mod+Alt+S" = "window-move-to-scratchpad";

        # --- Clipboard ---
        "Mod+V" = "spawn noctalia msg panel-toggle clipboard";

        # --- Screenshot ---
        "Mod+Shift+S" = "spawn noctalia msg screenshot-region";

        # --- Media Keys ---
        "XF86MonBrightnessUp" = "spawn noctalia msg brightness-up";
        "XF86MonBrightnessDown" = "spawn noctalia msg brightness-down";
        "XF86AudioRaiseVolume" = "spawn noctalia msg volume-up";
        "XF86AudioLowerVolume" = "spawn noctalia msg volume-down";
        "XF86AudioMute" = "spawn noctalia msg volume-mute";
        "XF86AudioPlay" = "spawn noctalia msg media toggle";
        "XF86AudioNext" = "spawn noctalia msg next";
        "XF86AudioPrev" = "spawn noctalia msg previous";
        "XF86AudioMicMute" = "spawn noctalia msg mic-mute";
      };
    };
  };

  programs.dconf.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    # --- SDDM ---
    (sddm-astronaut.override { embeddedTheme = "purple_leaves"; })
  ];
}
