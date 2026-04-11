{ config, pkgs, ... }:

{
    networking.hostName = "desktop";

    users.users.bruno.packages = with pkgs; [
    ];
}
