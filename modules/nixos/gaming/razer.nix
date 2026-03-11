{flake, pkgs, ...}:
let
  inherit (flake.config) me;
in
{
  hardware.openrazer = {
    enable = true;
    users = [me.username];

    batteryNotifier = {
      enable = true;
      percentage = 30;
      frequency = 1800; # in seconds
    };
  };

  environment.systemPackages = [pkgs.razergenie];
}
