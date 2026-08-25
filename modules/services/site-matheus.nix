{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.services.site-matheus;
  sitePkg = inputs.site-matheus.packages.${pkgs.system}.default or inputs.site-matheus.packages.x86_64-linux.default;
in
{
  options.services.site-matheus = {
    enable = lib.mkEnableOption "Web Service Site Matheus";

    port = lib.mkOption {
      type = lib.types.port;
      default = 8080;
      description = "HTTP Port";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.site-matheus = {
      description = "Web Service Site Matheus";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.python3}/bin/python3 -m http.server --bind 0.0.0.0 ${toString cfg.port} --directory ${sitePkg}/share/www";
        Restart = "always";
        User = "nobody";
      };
    };
  };
}
