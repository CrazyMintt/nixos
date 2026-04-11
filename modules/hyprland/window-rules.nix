{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # Transparência e Opacidade
      "opacity 0.9 0.9, match:class kitty"
      "opacity 1.0 override 1.0 override, match:class zen-twilight"

      # --- Picture in Picture ---
      "float on, match:title Picture-in-Picture"
      "pin on, match:title Picture-in-Picture"
    ];
  };
}
