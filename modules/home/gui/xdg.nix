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

    mimeApps = {
      enable = true;
      defaultApplicationPackages = [
        pkgs.vscodium
        inputs.zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".twilight
      ];
    };

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}