{ pkgs, ... }:
{
  imports = [ ../shared.nix ];
  wayland.windowManager.hyprland.settings = {
    monitor = ",1920x1080@144,auto,1";
    cursor.no_hardware_cursors = true;
  };
}
