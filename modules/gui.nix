# Graphical interface configuration (desktop hosts only)
{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";
    extraPackages = [
      pkgs.kdePackages.qtmultimedia
    ];
  };

  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland.overrideAttrs (oldAttrs: {
      postInstall = (oldAttrs.postInstall or "") + ''
        rm -f $out/share/wayland-sessions/hyprland-uwsm.desktop
      '';
      passthru = (oldAttrs.passthru or {}) // {
        providedSessions = [ "hyprland" ];
      };
    });
  };

  programs.dconf.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    # --- SDDM ---
    (sddm-astronaut.override { embeddedTheme = "purple_leaves"; })
  ];
}
