{flake, ...}:
let
  inherit (flake.config) me;
in
{
  hardware.openrazer = {
    enable = true;
    users = [me.username];
  };
}
