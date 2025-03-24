{ pkgs
, lib
, flake
, ...
}:
let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{

  imports =
    with builtins;
    map
      (fn: ./${fn})
      (filter (fn: fn != "default.nix") (attrNames (readDir ./.)));

  wayland.windowManager.hyprland = {
    enable = true;
    #package = inputs.hyprland.packages.hyprland;

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
  # services.hyprpaper = {
  #   enable = true;
  #   settings = {
  #     ipc = "off";
  #     splash = false;

  #     preload = [
  #       config.wallpaper

  #     ];

  #     wallpaper = [
  #       ",${config.wallpaper}"
  #     ];
  #   };
  # };

  ## MAIN HYPRLAND CONFIGURATION
  wayland.windowManager.hyprland.settings = {

    # General settings
    monitor = [
      # AORUS FI32U
      "HDMI-A-1,3840x2160@144,auto,2"
      # M27Q
      "HDMI-A-2,2560x1440,auto-right,2"
    ];


    "$terminal" = "warp-terminal";
    "$fileManager" = "nautilus";
    "$menu " = "rofi -show drun -show-icons -run-command \"uwsm app -- {cmd}\"";

    exec-once = [
      "gnome-keyring-daemon --start --components=secrets"
      "waybar & swaync & hyprpaper"
      "uwsm app -- hyprswitch init --show-title &"
      "uwsm app -- 1password --silent --ozone-platform-hint=x11"
      "uwsm app -- wlsunset -l 51.23 -L 6.78"
      "wl-paste --watch cliphist store"
    ];

    general = {
      allow_tearing = true;
      layout = "master";
      gaps_in = 10;
      gaps_out = "20 30";

      border_size = 2;
    };

    plugins = [
      #inputs.hyprland-virtual-desktops.packages.virtual-desktops
    ];

    env = [
      #"XCURSOR_SIZE,24"
      #"HYPRCURSOR_SIZE,24"
      #"GTK_THEME,juno"
      "GDK_SCALE,2"

      # nvidia specific
      "LIBVA_DRIVER_NAME,nvidia"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "__GL_VRR_ALLOWED,1"
      "WLR_DRM_NO_ATOMIC,1"
      "NVD_BACKEND,direct"
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
      no_hardware_cursors = 2;
      use_cpu_buffer = 2;
    };

    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      vrr = 2;
    };

    dwindle = {
      preserve_split = true;
      pseudotile = true;
    };

    master = {
      new_status = "master";
    };

    windowrulev2 = [
      "workspace 2, class:brave-browser"
      # Ignore maximize
      "suppressevent maximize, class:.*"

      #x11 bugfix
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

      # Volume control
      "float, class:org.pulseaudio.pavucontrol"
      "center 1, class:org.pulseaudio.pavucontrol"
      "size 50%, class:org.pulseaudio.pavucontrol"
      "stayfocused, class:org.pulseaudio.pavucontrol"

      # Steam Settings
      "workspace 3, class:steam"
      "float, class:steam,title: Friends List"
      "size 294 721, class:steam,title: Friends List"
      "float, class:steam,title: Steam Settings"

      # Smart Gaps
      # "bordersize 0, floating:0, onworkspace:w[tv1]"
      # "rounding 0, floating:0, onworkspace:w[tv1]"
      # "bordersize 0, floating:0, onworkspace:f[1]"
      # "rounding 0, floating:0, onworkspace:f[1]"
    ];

    workspace = [
      # "w[tv1], gapsout:0, gapsin:0"
      # "f[1], gapsout:0, gapsin:0"

      "2, monitor:HDMI-A-1"
      "5, monitor:HDMI-A-2"
    ];
  };

}
