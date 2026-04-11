{ config, pkgs, ... }:

{
    networking.hostName = "notebook";

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };
    services.blueman.enable = true;

    users.users.bruno.packages = with pkgs; [
        bruno
        gemini-cli
        taskwarrior3
        taskwarrior-tui
        vscode
    ];
}