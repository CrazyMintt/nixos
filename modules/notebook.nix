{ config, pkgs, ... }:

{
    networking.hostName = "notebook";

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };
    services.blueman.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;

    users.users.bruno.packages = with pkgs; [
        # --- Api ---
        bruno

        # --- Code ---
        gemini-cli
        
        # --- To Do ---
        taskwarrior3
        taskwarrior-tui
        
        # --- College ---
        processing
    ];
}