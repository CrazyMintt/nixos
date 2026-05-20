{ pkgs, ... }:

{
    networking.hostName = "notebook";

    # --- Bluetooth ---
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true;
    };
    services.blueman.enable = true;

    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;

    # --- Docker ---
    virtualisation.docker.enable = true;
    users.users.bruno.extraGroups = [ "docker" ];

    services.tailscale.enable = true;

    users.users.bruno.packages = with pkgs; [
        # --- Api ---
        bruno

        # --- Code ---
        gemini-cli
        
        # --- Etc ---
        rpi-imager
        
        # --- College ---
        processing
    ];
}