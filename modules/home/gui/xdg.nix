{
  pkgs,
  flake,
  ...
}:
let
  inherit (flake) inputs;

in
{
  xdg = {
    enable = true;

    # Hide the following desktop entries for launcher.
    desktopEntries = {
      uuctl = {
        name = "uuctl";
        noDisplay = true;
      };
      qt6ct = {
        name = "qt6ct";
        noDisplay = true;
      };
      kvantummanager = {
        name = "kvantum";
        noDisplay = true;
      };
    };
    
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}