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
    "${homeModules}/programs/waybar.nix"
    #"${homeModules}/services/stylix.nix"

    "${homeModules}/programs/rofi.nix"
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
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.yaru-theme;
    name = "Yaru";
    size = 24;
  };

  # Source hyprland config from the home-manager store
  # NOT DOING THIS ... see below
  # xdg.configFile = {
  #   "hypr/hyprland.conf" = {
  #     source = ./hyprland.conf;
  #   };
  # };

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
      splash = true;

      preload = [
        config.wallpaper

      ];

      wallpaper = [
        ",${config.wallpaper}"
      ];
    };
  };

  ## MAIN HYPRLAND CONFIGURATION
  wayland.windowManager.hyprland.settings = {

    # General settings
    monitor = ",preferred,auto,2";
    "$mainMod" = "SUPER";
    "$mod" = "alt";
    "$reverse" = "grave";
    "$key" = "Tab";

    "$terminal" = "kitty";
    "$fileManager" = "nautilus";
    "$menu " = "rofi -show drun -show-icons";

    exec-once = [
      "gnome-keyring-daemon --start --components=secrets"
      "waybar & swaync & hyprpaper & hyprsunset"
      "hyprswitch init --show-title &"
      "1password --silent"
    ];

    bind =
      [
        # Alt+Tab to switch between windows
        "$mod, $key, exec, hyprswitch gui --mod-key $mod --key $key --close mod-key-release --reverse-key=key=$reverse && hyprswitch dispatch"
        "$mod $reverse, $key, exec, hyprswitch gui --mod-key $mod --key $key --close mod-key-release --reverse-key=key=$reverse && hyprswitch dispatch -r"

        # Default behaviours
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive,"
        "$mainMod, M, exit,"
        "$mainMod, R, exec, $menu"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      ));

    bindm = [
      # Move windows
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"

      # nvidia specific
      "LIBVA_DRIVER_NAME,nvidia"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "__GL_VRR_ALLOWED,1"
      "WLR_DRM_NO_ATOMIC,1"
    ];

    xwayland = {
      force_zero_scaling = true;
    };

    cursor = {
      no_warps = true;
    };
  };
}
