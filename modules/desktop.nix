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
}
