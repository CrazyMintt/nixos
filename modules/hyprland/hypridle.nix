{ ... }:
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "noctalia-shell ipc call lockScreen lock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 60000;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 180000;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
