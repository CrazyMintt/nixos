{ config, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    extraPackages = with pkgs; [
      # NixOS
      nil
      nixd
      nixfmt
    ];
    extensions = [
      "nix"
    ];
    userSettings = {
      disable_ai = true;
      autosave = {
        after_delay = {
          milliseconds = 500;
        };
      };
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      theme = {
        mode = "dark";
        light = "Noctalia Light";
        dark = "Noctalia Dark";
      };
      # --- UI ---
      ## --- Layout --- 
      terminal = {
        button = false;
      };
      title_bar = {
        show_sign_in = false;
        show_user_menu = false;
      };
      tab_bar = {
        show_tab_bar_buttons = false;
      };
      ## --- Panel ---
      project_panel = {
        folder_icons = false;
        entry_spacing = "standard";
        dock = "left";
      };
      git_panel = {
        tree_view = true;
        dock = "left";
      };
      collaboration_panel = {
        button = false;
      };
      outline_panel = {
        button = false;
        dock = "left";
      };
      git = {
        inline_blame = {
          enabled = false;
        };
      };
    };
    userKeymaps = 
    [
      {
        context = "Editor";
        bindings = {
          "ctrl-;" = [
            "editor::ToggleComments"
            {
              "advance_downwards" = false;
            }
          ];
        };
      }
    ];
    themes.text = "${config.home.homeDirectory}/.config/zed/themes/noctalia.json";
  };
}