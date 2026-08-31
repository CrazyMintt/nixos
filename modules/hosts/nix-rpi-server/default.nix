{ pkgs, lib, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/installer/sd-card/sd-image.nix"
    ./rpi-zero-w.nix
    ./minification.nix
    ./wifi.nix
  ];

  # Network & Hostname
  networking.hostName = "nix-rpi-server";
  networking.wireless.enable = true;

  # Server decrypts secrets using SSH host key only
  sops.age.keyFile = lib.mkForce null;

  # Mount Raspberry Pi boot firmware partition permanently
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/FIRMWARE";
    fsType = "vfat";
    options = [ "nofail" "noatime" ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Tailscale VPN Service
  services.tailscale.enable = true;
  nixpkgs.overlays = [
    (final: prev: {
      tailscale = prev.tailscale.overrideAttrs (oldAttrs: {
        GOARM = "6";
      });
    })
  ];

  services.rpi-portal = {
    enable = true;
    port = 8080;
  };

  services.site-matheus = {
    enable = true;
    port = 8081;
  };

  services.nerd-run = {
    enable = true;
    port = 8082;
  };

  # Nix daemon trusted users
  nix.settings.trusted-users = [ "root" "pi" ];

  # System packages
  environment.systemPackages = with pkgs; [
    libraspberrypi
    libgpiod
    gpio-utils
    i2c-tools
    screen
    vim
    git
    btop
    tailscale
  ];

  # Hardware i2c & boot params
  boot = {
    supportedFilesystems = lib.mkForce [ "vfat" "ext4" "f2fs" ];
    kernelModules = [
      "i2c-dev"
    ];
  };
  hardware.i2c.enable = true;

  # Users & SSH
  users = {
    extraGroups = {
      gpio = {};
    };
    users.pi = {
      isNormalUser = true;
      initialPassword = "raspberry";
      extraGroups = [ "wheel" "networkmanager" "dialout" "gpio" "i2c" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC/w7vklesbW3hHR2TmVYkkCs2WPjIfDbeYFPUdd0txz brunoopuszkamachado@gmail.com"
      ];
    };
  };

  # Passwordless sudo for wheel group to allow seamless remote deployments
  security.sudo.wheelNeedsPassword = false;

  services.getty.autologinUser = "pi";

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "prohibit-password";
    };
  };

  services.udev.extraRules = ''
    KERNEL=="gpiochip0*", GROUP="gpio", MODE="0660"
  '';

  system.stateVersion = "24.11";
}
