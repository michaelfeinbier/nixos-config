{ ... }:
{
  services.hypridle = {
    enable = false; # We manage it now via noctalia
    settings = {
      general = {
        before_sleep_cmd = "noctalia-shell ipc call lockScreen lock";
        after_sleep_cmd = "niri msg action power-on-monitors";
        lock_cmd = "noctalia-shell ipc call lockScreen lock";
      };

      listener = [
        # Turn off monitors after 20 minutes
        {
          timeout = 1200;
          on-timeout = "niri msg action power-off-monitors";
          on-resume = "niri msg action power-on-monitors";
        }
        # Suspend after 60 minutes
        {
          timeout = 3600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}