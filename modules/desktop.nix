{ config, pkgs, ... }:

{
    networking.hostName = "desktop";

    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    
    services.xserver.videoDrivers = [ "nvidia" ];

    users.users.bruno.packages = with pkgs; [
      protonup-qt
    ];

    home-manager.users.bruno = { ... }: {
      xdg.configFile."yazi/keymap.toml".text = ''
          [mgr]
          prepend_keymap = [
         	  { on = [ "g", "d" ], run = "cd ~/Dev", desc = "Go to Dev folder" }
          ]
          append_keymap = [
         	  { on = [ "g", "o" ], run = "cd ~/Obsidian", desc = "Go to Obsidian folder" }
          ]
          '';
    };
}
