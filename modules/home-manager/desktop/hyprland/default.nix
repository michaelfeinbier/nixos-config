{
  homeModules,
  pkgs,
  config,
  lib,
  inputs,
  #catppuccin,
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

    # Disable this here to avoid conflict with NIX wayland
    systemd.enable = false;
  };

  #catppuccin.flavor = "mocha";
  # for now global enable, maybe finetune later
  #catppuccin.enable = true;

  # Install swaync via home-manager module
  services.swaync = {
    enable = true;
  };

  # Set the wallpaper
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

  ## MAIN HYPRLAND CONFIGURATION
  wayland.windowManager.hyprland.settings = {

    # General settings
    monitor = ",3840x2160@144,auto,1.6";
    "$mainMod" = "SUPER";
    "$mod" = "alt";
    "$reverse" = "grave";
    "$key" = "Tab";

    "$terminal" = "alacritty";
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
        "$mainMod, SPACE, exec, $menu"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mainMod, ${toString ws}, workspace, ${toString ws}"
            "$mainMod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      ));

    general = {
      allow_tearing = true;
    };

    bindm = [
      # Move windows
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    env = [
      #"XCURSOR_SIZE,24"
      #"HYPRCURSOR_SIZE,24"
      #"GTK_THEME,juno"

      # nvidia specific
      "LIBVA_DRIVER_NAME,nvidia"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "__GL_VRR_ALLOWED,1"
      "WLR_DRM_NO_ATOMIC,1"
    ];

    input = {
      kb_layout = "us,de";
      #kb_options = "grp:win_space_toggle";
      follow_mouse = true;

      natural_scroll = true;
    };

    # Optics: Window decorations, animations, etc.
    decoration = {
      rounding = 8;
      blur = {
        enabled = false;
        size = 3;
        passes = 1;
      };

      shadow = {
        enabled = false;
        range = 4;
        render_power = 3;
        color = lib.mkDefault "rgba(1a1a1aee)";
      };
    };

    animations = {
      enabled = true;

      bezier = [
        "easeOutQuint,0.23,1,0.32,1"
        "easeInOutCubic,0.65,0.05,0.36,1"
        "linear,0,0,1,1"
        "almostLinear,0.5,0.5,0.75,1.0"
        "quick,0.15,0,0.1,1"
      ];

      animation = [
        "global, 1, 10, default"
        "border, 1, 5.39, easeOutQuint"
        "windows, 1, 4.79, easeOutQuint"
        "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
        "windowsOut, 1, 1.49, linear, popin 87%"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fade, 1, 3.03, quick"
        "layers, 1, 3.81, easeOutQuint"
        "layersIn, 1, 4, easeOutQuint, fade"
        "layersOut, 1, 1.5, linear, fade"
        "fadeLayersIn, 1, 1.79, almostLinear"
        "fadeLayersOut, 1, 1.39, almostLinear"
        "workspaces, 1, 1.94, almostLinear, fade"
        "workspacesIn, 1, 1.21, almostLinear, fade"
        "workspacesOut, 1, 1.94, almostLinear, fade"
      ];
    };

    xwayland = {
      force_zero_scaling = true;
    };

    cursor = {
      no_warps = true;
      no_hardware_cursors = true;
    };

    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      vrr = 1;
    };

    dwindle = {
      preserve_split = true;
      pseudotile = true;
    };

    master = {
      new_status = "master";
    };

    windowrulev2 = [
      # Steam on WS3
      "workspace 3, class:steam"

      # Ignore maximize
      "suppressevent maximize, class:.*"

      #x11 bugfix
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
    ];
  };

}