{ config, ... }:

{
  sops.secrets.wifi-env = {};

  networking = {
    wireless = {
      environmentFile = config.sops.secrets.wifi-env.path;

      networks = {
        "@WIFI_SSID@" = {
            psk = "@WIFI_PASSWORD@";
        };
      };
    };
  };
}
