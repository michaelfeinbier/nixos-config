{
  homeModules,
  pkgs,
  config,
  lib,
  inputs,
  catppuccin,
  ...
}:
{
  imports = [
    "${homeModules}/services/waybar.nix"
    "${homeModules}/services/stylix.nix"
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    #package = null;
    #portalPackage = null;
  };

  catppuccin.flavor = "mocha";
  # for now global enable, maybe finetune later
  catppuccin.enable = true;

  # Consistent cursor theme across all applications.
  # home.pointerCursor = {
  #   gtk.enable = true;
  #   x11.enable = true;
  #   package = pkgs.yaru-theme;
  #   name = "Yaru";
  #   size = 24;
  # };

  # Source hyprland config from the home-manager store
  xdg.configFile = {
    "hypr/hyprland.conf" = {
      source = ./hyprland.conf;
    };
  };

  # Install swaync via home-manager module
  services.swaync = {
    enable = true;
  };

  # Source swaync config from the home-manager store
  #$xdg.configFile = {
  # "swaync/style.css" = {
  #   source = ./style.css;
  # };
  #};

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
