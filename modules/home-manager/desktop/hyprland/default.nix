{
  homeModules,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    "${homeModules}/services/waybar.nix"
  ];

  # Consistent cursor theme across all applications.
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.yaru-theme;
    name = "Yaru";
    size = 24;
  };

  # Source hyprland config from the home-manager store
  xdg.configFile = {
    "hypr/hyprland.conf" = {
      source = ./hyprland.conf;
    };
  };

  # Set the default wallpaper
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;

      preload = [
        config.wallpaper

      ];

      wallpaper = [
        ",${config.wallpaper}"
      ];
    };
  };
}
