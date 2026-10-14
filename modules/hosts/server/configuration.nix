{ config, lib, pkgs, ... }:

{
  # --- Boot (legacy BIOS) ---
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.firewall.interfaces."tailscale0".allowedTCPPorts = [ 22 ];
  nix.settings.trusted-users = [ "root" "bruno" ];
  
  services.openssh = {
    enable = true;
    openFirewall = false;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      AllowUsers = [ "bruno" ];
    };
  };

  services.smartd = {
    enable = true;
    autodetect = true;
    notifications.wall.enable = true;
  };
  
  services.forgejo = {
    enable = true;
    lfs.enable = true;
    stateDir = "/mnt/hd1/forgejo";
    settings = {
      server = {
        HTTP_ADDR = "127.0.0.1";
        HTTP_PORT = 7555;
        DOMAIN = "server.tailf054ea.ts.net";
        ROOT_URL = "https://server.tailf054ea.ts.net:8443/";
      };
      service = {
        DISABLE_REGISTRATION = true;
        REQUIRE_SIGNIN_VIEW = true;
        DISABLE_USERS_PAGE = true;
      };
      session.COOKIE_SECURE = true;
    };
  };

  services.nginx.virtualHosts."${config.services.nextcloud.hostName}".listen = [
    { addr = "127.0.0.1"; port = 7556; }
  ];
  
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud35;
    hostName = "server.tailf054ea.ts.net";
    https = false;
    datadir = "/mnt/hd1/nextcloud";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "pgsql";
    config.dbhost = "/run/postgresql";
    database.createLocally = true;
  
    settings = {
      simpleSignUpLink.shown = false;
      trusted_domains = [ "server.tailf054ea.ts.net" "server" "100.68.184.70" ];
      overwritehost = "server.tailf054ea.ts.net";
      overwriteprotocol = "https";
      trusted_proxies = [ "127.0.0.1" ];
    };
  };

  systemd.services.forgejo.unitConfig.RequiresMountsFor = "/mnt/hd1";
  systemd.services.nextcloud-setup.unitConfig.RequiresMountsFor = "/mnt/hd1";
  systemd.services.phpfpm-nextcloud.unitConfig.RequiresMountsFor = "/mnt/hd1";
  
  systemd.services.tailscale-serve = {
    description = "Tailscale serve: HTTPS -> Nextcloud and Forgejo";
    after = [ "tailscaled.service" "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      until ${config.services.tailscale.package}/bin/tailscale status >/dev/null 2>&1; do
        sleep 2
      done
      ${config.services.tailscale.package}/bin/tailscale serve --bg --https=443  http://127.0.0.1:7556
      ${config.services.tailscale.package}/bin/tailscale serve --bg --https=8443 http://127.0.0.1:7555
    '';
  };

  users.users.bruno.extraGroups = [ "wheel" ];
  users.users.bruno.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHZsgeQI65IWupcDbqO5Z7RPT+fttg6jHxfxCgb+EZuK brunoopuszkamachado@gmail.com"
  ];
}
