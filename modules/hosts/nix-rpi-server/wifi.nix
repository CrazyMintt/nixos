{ config, ... }:

{
  sops.secrets.wifi-env = {};

  networking = {
    wireless = {
      secretsFile = config.sops.secrets.wifi-env.path;

      networks = {
        "CLARO_SOB6" = {
          pskRaw = "ext:WIFI_PASSWORD";
        };
      };
    };
  };
}
