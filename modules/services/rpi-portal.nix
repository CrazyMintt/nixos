{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.services.rpi-portal;
  rpiPortalPkg = inputs.rpi-portal.packages.${pkgs.system}.default or inputs.rpi-portal.packages.x86_64-linux.default;
in
{
  options.services.rpi-portal = {
    enable = lib.mkEnableOption "Portal to show running services";

    port = lib.mkOption {
      type = lib.types.port;
      default = 8080;
      description = "HTTP Port";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.rpi-portal = {
      description = "Portal to show running services";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.python3}/bin/python3 -m http.server --bind 0.0.0.0 ${toString cfg.port} --directory ${rpiPortalPkg}/share/www";
        Restart = "always";
        User = "nobody";
      };
    };
  };
}
