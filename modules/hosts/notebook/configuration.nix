{ pkgs, ... }:

{
  networking.hostName = "notebook";

  # --- Bluetooth ---
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
  services.power-profiles-daemon.enable = true;
  services.printing.enable = true;
  services.upower.enable = true;

  # --- Docker ---
  virtualisation.docker.enable = true;
  users.users.bruno.extraGroups = [ "docker" ];

  users.users.bruno.packages = with pkgs; [
    # --- Api ---
    bruno
    
    # --- Etc ---
    rpi-imager
  ];

  home-manager.users.bruno = { ... }: {
    xdg.configFile."yazi/keymap.toml".text = ''
      [mgr]
      prepend_keymap = [
     	  { on = [ "g", "d" ], run = "cd /mnt/hd/Dev", desc = "Go to Dev folder" }
      ]
      append_keymap = [
     	  { on = [ "g", "o" ], run = "cd /mnt/hd/Obsidian", desc = "Go to Obsidian folder" },
        { on = [ "g", "H" ], run = "cd /mnt/hd", desc = "Go to HD folder" }
      ]
    '';

    xdg.configFile."yazi/yazi.toml".text = ''
      [opener]
      edit = [
        { run = "zeditor --classic %s", block = true, for = "unix" }
      ]
    '';
  };
}