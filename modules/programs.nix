{ pkgs, inputs, config,... }:

let
  spicetify = inputs.spicetify-nix.lib.mkSpicetify pkgs {
  };
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in

{
    imports = [
        inputs.zen-browser.homeModules.twilight
        inputs.spicetify-nix.homeManagerModules.spicetify
    ];

    programs.zen-browser.enable = true;

    programs.spicetify = {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        ];
    };

    programs.yazi = {
        enable = true;
        shellWrapperName = "y";
    };

    programs.zed-editor = {
      enable = true;
      extraPackages = with pkgs; [
        # NixOS
        nixd
        nixfmt
      ];
      extensions = [
        "nix"
      ];
      userSettings = {
        telemetry = {
          metrics = false;
        };
        theme = {
          mode = "dark";
          light = "One Light";
          dark = "Noctalia Dark";
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

    home.packages = with pkgs; [
        # --- Etc ---
        gh
        keepassxc
        libreoffice
        localsend

        # --- Code ---
        vscode

        # --- Notes ---
        obsidian

        # --- Hyprland ---
        bibata-cursors
        hyprshot

        # --- File Picker ---
        nautilus
    ];
}
