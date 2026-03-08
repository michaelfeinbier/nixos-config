{flake, pkgs, ...}:
let
  inherit (flake.config) me;
in
{
  hardware.openrazer = {
    enable = true;
    users = [me.username];
  };

  environment.systemPackages = [pkgs.razergenie];
}
