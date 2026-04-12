{ pkgs, ... }:
{
  imports = [ ../shared.nix ];
  wayland.windowManager.hyprland.settings = {
    monitor = ",preferred,auto,1";
    cursor.no_hardware_cursors = false;
  };
}
