{flakes, ...}:
let
  inherit (flakes.config) me;
in
{
  hardware.openrazer = {
    enable = true;
    users = [me.username];
  };
}
