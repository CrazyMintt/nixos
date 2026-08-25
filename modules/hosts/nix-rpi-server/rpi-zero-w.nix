{ config, lib, pkgs, ... }:

{
  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = false;
    };

    kernelPackages = pkgs.linuxPackages;
    consoleLogLevel = lib.mkDefault 7;

    # prevent `modprobe: FATAL: Module ahci not found`
    initrd.availableKernelModules = pkgs.lib.mkForce [
      "mmc_block"
    ];
  };

  sdImage = {
    populateRootCommands = "";
    populateFirmwareCommands = with config.system.build; ''
      ${installBootLoader} ${toplevel} -d ./firmware
    '';
    firmwareSize = 64;
  };

  hardware = {
    enableRedistributableFirmware = true;
    firmware = with pkgs; [
      raspberrypiWirelessFirmware
    ];
  };
}
