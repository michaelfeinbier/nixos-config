{...}:

{
  services.hypridle = {
    enable = true;
    settings = {
      #idleTime = 1800;
      #idleCommand = "systemctl suspend";

      listener = [{
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
      }];
    };
  };
}