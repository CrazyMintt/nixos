{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.services.nerd-run;
  nerdPkg = inputs.nerd-run.packages.${pkgs.system}.default or inputs.nerd-run.packages.x86_64-linux.default;
in
{
  options.services.nerd-run = {
    enable = lib.mkEnableOption "Web Service Nerd Run";

    port = lib.mkOption {
      type = lib.types.port;
      default = 8082;
      description = "HTTP Port";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.nerd-run = {
      description = "Web Service Nerd Run";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = "${pkgs.python3}/bin/python3 -m http.server --bind 0.0.0.0 ${toString cfg.port} --directory ${nerdPkg}/share/www";
        Restart = "always";
        User = "nobody";
      };
    };
  };
}
