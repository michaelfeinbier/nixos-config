{ flake, ... }:
let
  inherit (flake) inputs;
in
{
  stylix.targets.niri.enable = true;

  programs.niri.settings = {
    # Input
    input = {
      keyboard = {
        xkb.layout = "us,de";
        repeat-delay = 250;
        repeat-rate = 40;
        numlock = true;
      };

      touchpad.enable = false;

      mouse = {
        natural-scroll = true;
        accel-profile = "flat";
      };

      trackpoint.enable = false;

      focus-follows-mouse = {
        enable = true;
        max-scroll-amount = "0%";
      };

      mod-key = "Alt";
      mod-key-nested = "Super";
    };

    # Output
    outputs."HDMI-A-1" = {
      variable-refresh-rate = "on-demand";
      mode = {
        width = 3840;
        height = 2160;
        refresh = 144.0;
      };
      scale = 2.0;
    };

    # Layout
    layout = {
      background-color = "transparent";
      gaps = 6;
      center-focused-column = "never";

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];

      default-column-width = { proportion = 0.5; };

      focus-ring = {
        enable = false;
        width = 1;
        #active.color = "#b7bdf8";
        #inactive.color = "#494d64";
      };

      border = {
        enable = true;
        width = 2;
        #active.color = "#798ebd";
        #inactive.color = "#665c54";
        #urgent.color = "#9b0000";
      };

      shadow = {
        enable = true;
        softness = 30;
        spread = 5;
        offset = { x = 0; y = 5; };
        color = "#181926aa";
      };
    };

    # Spawn at startup
    spawn-at-startup = [
      { sh = "systemctl --user restart xremap"; }
      { argv = [ "1password" "--silent" ]; }
    ];

    prefer-no-csd = true;

    screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

    # Animations from https://github.com/rickinshah/0xNiri/blob/main/.config/niri/config.kdl#L183
    animations = {
      enable = true;
      slowdown = 0.8;

      window-close = {
        kind.easing = {
          duration-ms = 250;
          curve = "ease-out-quad";
        };
      };
      screenshot-ui-open = {
        kind.easing = {
          duration-ms = 500;
          curve = "ease-out-quad";
        };
      };
      workspace-switch = {
        kind.spring = {
          damping-ratio = 0.7;
          stiffness = 200;
          epsilon = 0.0001;
        };
      };
      config-notification-open-close = {
        kind.spring = {
          damping-ratio = 0.7;
          stiffness = 200;
          epsilon = 0.0001;
        };
      };
      overview-open-close = {
        kind.spring = {
          damping-ratio = 0.7;
          stiffness = 200;
          epsilon = 0.001;
        };
      };
      horizontal-view-movement = {
        kind.spring = {
          damping-ratio = 0.7;
          stiffness = 200;
          epsilon = 0.0001;
        };
      };
      window-resize = {
        kind.spring = {
          damping-ratio = 0.7;
          stiffness = 200;
          epsilon = 0.0001;
        };
      };
      window-open = {
        kind.spring = {
          damping-ratio = 0.7;
          stiffness = 200;
          epsilon = 0.0001;
        };
      };
      window-movement = {
        kind.spring = {
          damping-ratio = 0.7;
          stiffness = 200;
          epsilon = 0.0001;
        };
      };
    };

    # Workspaces (prefixed keys for deterministic ordering)
    workspaces = {
      "0-main" = { name = "main"; };
      "1-terminal" = { name = "terminal"; };
      "2-steam" = { name = "steam"; };
      "3-games" = { name = "games"; };
    };

    # Layer rules
    layer-rules = [
      {
        matches = [{ namespace = "^noctalia-overview.*"; }];
        place-within-backdrop = true;
      }
    ];

    # Debug
    debug = {
      honor-xdg-activation-with-invalid-serial = true;
    };

    # Window rules
    window-rules = [
      # Global: rounded corners
      {
        geometry-corner-radius = let r = 12.0; in {
          top-left = r;
          top-right = r;
          bottom-left = r;
          bottom-right = r;
        };
        clip-to-geometry = true;
      }

      # Zen browser
      {
        matches = [{ app-id = "^zen.*"; }];
        default-column-width = { proportion = 1.0; };
        open-on-workspace = "main";
      }
      # Zen picture in picture
      {
        matches = [{ app-id = "^zen.*"; title="Picture-in-Picture";}]; 
        focus-ring.enable = false;
        border.enable = false;
        shadow.enable = false;
        open-floating = true;
        geometry-corner-radius = let r = 0.0; in {
          top-left = r;
          top-right = r;
          bottom-left = r;
          bottom-right = r;
        };
        default-floating-position = {
          x = 100;
          y = 200;
          relative-to = "bottom-right";
        };
      }


      # Alacritty & Ghostty
      {
        matches = [
          { app-id = "^Alacritty$"; }
          { app-id = "^com.mitchellh.ghostty$"; }
        ];
        default-column-width = { proportion = 0.5; };
        open-on-workspace = "terminal";
        #open-maximized = true;
      }

      # Steam
      {
        matches = [{ app-id = "^steam$"; }];
        default-column-width = { proportion = 0.75; };
        open-on-workspace = "steam";
      }

      # Steam Friends
      {
        matches = [{ app-id = "^steam$"; title = "Friends List"; }];
        default-column-width = { proportion = 0.25; };
        open-on-workspace = "steam";
      }

      # Steam games - workspace
      {
        matches = [{ app-id = "^steam_app_\\d+$"; }];
        open-on-workspace = "games";
      }

      # Steam games - fullscreen + VRR
      {
        matches = [{ app-id = "^steam_app_\\d+$"; }];
        excludes = [{ title = "^$"; }];
        open-fullscreen = true;
        variable-refresh-rate = true;
      }

      # Gamescope - fullscreen + VRR
      {
        matches = [{ app-id = "^gamescope$"; }];
        excludes = [{ title = "^$"; }];
        open-fullscreen = true;
        variable-refresh-rate = true;
      }

      # Pavucontrol
      {
        matches = [{ app-id = "^org\\.pulseaudio\\.pavucontrol$"; }];
        open-floating = true;
      }

      # Chrome extensions
      {
        matches = [{ title = "^_crx_.*$"; }];
        open-floating = true;
        block-out-from = "screencast";
      }

      # Calculator
      {
        matches = [{ app-id = "^(gnome-calculator|org\\.gnome\\.Calculator)$"; }];
        open-floating = true;
      }

      # Albert launcher
      {
        matches = [{ title = "^Albert$"; }];
        focus-ring.enable = false;
        border.enable = false;
        shadow.enable = false;
        open-floating = true;
        default-floating-position = {
          x = 0;
          y = 300;
          relative-to = "top";
        };
      }

      # Screen sharing indicator
      {
        matches = [{ title = "^.*is sharing (your screen|a window)\\.$"; }];
        focus-ring.enable = false;
        border.enable = false;
        open-floating = true;
        default-floating-position = {
          x = 0;
          y = 0;
          relative-to = "bottom";
        };
      }
    ];

    # Keybindings
    binds = {
      # Hotkey overlay
      "Mod+Shift+Slash".action.show-hotkey-overlay = {};

      # Programs
      "Mod+T" = {
        action.spawn = ["ghostty" "+new-window"];
        hotkey-overlay.title = "Open Terminal";
      };
      "Mod+B" = {
        action.spawn = "zen";
        hotkey-overlay.title = "Open Zen Browser";
      };
      "Mod+F" = {
        action.spawn = "nautilus";
        hotkey-overlay.title = "Open Nautilus";
      };
      "Super+Alt+L" = {
        action.spawn = "swaylock";
        hotkey-overlay.title = "Lock the Screen: swaylock";
      };

      # Albert
      "Mod+A" = {
        action.spawn = [ "albert" "show" "apps " ];
        hotkey-overlay.title = "Open Albert Apps";
      };
      "Super+Space" = {
        action.spawn = [ "albert" "toggle" ];
        hotkey-overlay.title = "Toggle Albert";
      };

      # Clipboard history
      "Mod+Super+C" = {
        action.spawn-sh = "noctalia-shell ipc call plugin:clipper toggle";
        hotkey-overlay.title = "Clipboard History";
      };

      # Orca screen reader
      "Super+Alt+S" = {
        action.spawn-sh = "pkill orca || exec orca";
        allow-when-locked = true;
        hotkey-overlay.hidden = true;
      };

      # Volume
      "XF86AudioRaiseVolume" = {
        action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
        allow-when-locked = true;
      };
      "XF86AudioLowerVolume" = {
        action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        allow-when-locked = true;
      };
      "XF86AudioMute" = {
        action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        allow-when-locked = true;
      };
      "XF86AudioMicMute" = {
        action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        allow-when-locked = true;
      };

      # Media
      "XF86AudioPlay" = {
        action.spawn-sh = "playerctl play-pause";
        allow-when-locked = true;
      };
      "XF86AudioStop" = {
        action.spawn-sh = "playerctl stop";
        allow-when-locked = true;
      };
      "XF86AudioPrev" = {
        action.spawn-sh = "playerctl previous";
        allow-when-locked = true;
      };
      "XF86AudioNext" = {
        action.spawn-sh = "playerctl next";
        allow-when-locked = true;
      };

      # Brightness
      "XF86MonBrightnessUp" = {
        action.spawn = [ "brightnessctl" "--class=backlight" "set" "+10%" ];
        allow-when-locked = true;
      };
      "XF86MonBrightnessDown" = {
        action.spawn = [ "brightnessctl" "--class=backlight" "set" "10%-" ];
        allow-when-locked = true;
      };

      # Overview
      "Super+O" = {
        action.toggle-overview = {};
        repeat = false;
      };

      # Close window
      "Super+Q" = {
        action.close-window = {};
        repeat = false;
      };

      # Focus navigation
      "Mod+Left".action.focus-column-left = {};
      "Mod+Down".action.focus-window-down = {};
      "Mod+Up".action.focus-window-up = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+H".action.focus-column-left = {};
      "Mod+J".action.focus-window-down = {};
      "Mod+K".action.focus-window-up = {};
      "Mod+L".action.focus-column-right = {};

      # Move columns/windows
      "Mod+Ctrl+Left".action.move-column-left = {};
      "Mod+Ctrl+Down".action.move-window-down = {};
      "Mod+Ctrl+Up".action.move-window-up = {};
      "Mod+Ctrl+Right".action.move-column-right = {};
      "Mod+Ctrl+H".action.move-column-left = {};
      "Mod+Ctrl+J".action.move-window-down = {};
      "Mod+Ctrl+K".action.move-window-up = {};
      "Mod+Ctrl+L".action.move-column-right = {};

      # First/Last column
      "Mod+Home".action.focus-column-first = {};
      "Mod+End".action.focus-column-last = {};
      "Mod+Ctrl+Home".action.move-column-to-first = {};
      "Mod+Ctrl+End".action.move-column-to-last = {};

      # Monitor focus
      "Mod+Shift+Left".action.focus-monitor-left = {};
      "Mod+Shift+Down".action.focus-monitor-down = {};
      "Mod+Shift+Up".action.focus-monitor-up = {};
      "Mod+Shift+Right".action.focus-monitor-right = {};
      "Mod+Shift+H".action.focus-monitor-left = {};
      "Mod+Shift+J".action.focus-monitor-down = {};
      "Mod+Shift+K".action.focus-monitor-up = {};
      "Mod+Shift+L".action.focus-monitor-right = {};

      # Move to monitor
      "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = {};
      "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = {};
      "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = {};
      "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = {};
      "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = {};
      "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = {};
      "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = {};
      "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = {};

      # Workspace navigation
      "Mod+Page_Down".action.focus-workspace-down = {};
      "Mod+Page_Up".action.focus-workspace-up = {};
      "Mod+U".action.focus-workspace-down = {};
      "Mod+I".action.focus-workspace-up = {};
      "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = {};
      "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = {};
      "Mod+Ctrl+U".action.move-column-to-workspace-down = {};
      "Mod+Ctrl+I".action.move-column-to-workspace-up = {};

      # Move workspace
      "Mod+Shift+Page_Down".action.move-workspace-down = {};
      "Mod+Shift+Page_Up".action.move-workspace-up = {};
      "Mod+Shift+U".action.move-workspace-down = {};
      "Mod+Shift+I".action.move-workspace-up = {};

      # Mouse wheel - workspace
      "Mod+WheelScrollDown" = {
        action.focus-workspace-down = {};
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action.focus-workspace-up = {};
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollDown" = {
        action.move-column-to-workspace-down = {};
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollUp" = {
        action.move-column-to-workspace-up = {};
        cooldown-ms = 150;
      };

      # Mouse wheel - column
      "Mod+WheelScrollRight".action.focus-column-right = {};
      "Mod+WheelScrollLeft".action.focus-column-left = {};
      "Mod+Ctrl+WheelScrollRight".action.move-column-right = {};
      "Mod+Ctrl+WheelScrollLeft".action.move-column-left = {};

      # Shift wheel
      "Mod+Shift+WheelScrollDown".action.focus-column-right = {};
      "Mod+Shift+WheelScrollUp".action.focus-column-left = {};
      "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = {};
      "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = {};

      # Workspace by index
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      # Window management
      "Mod+BracketLeft".action.consume-or-expel-window-left = {};
      "Mod+BracketRight".action.consume-or-expel-window-right = {};
      "Mod+Comma".action.consume-window-into-column = {};
      "Mod+Period".action.expel-window-from-column = {};

      "Mod+R".action.switch-preset-column-width = {};
      "Mod+Shift+R".action.switch-preset-window-height = {};
      "Mod+Ctrl+R".action.reset-window-height = {};
      "Mod+Shift+F".action.maximize-column = {};
      "Mod+M".action.maximize-window-to-edges = {};
      "Mod+Ctrl+F".action.expand-column-to-available-width = {};
      "Mod+C".action.center-column = {};

      # Resize
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      # Floating
      "Mod+V".action.toggle-window-floating = {};
      "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = {};

      # Tabbed
      "Mod+W".action.toggle-column-tabbed-display = {};

      # Screenshots
      "Print".action.screenshot = {};
      "Ctrl+Print".action.screenshot-screen = {};
      "Alt+Print".action.screenshot-window = {};

      # Keyboard shortcuts inhibitor
      "Mod+Escape" = {
        action.toggle-keyboard-shortcuts-inhibit = {};
        allow-inhibiting = false;
      };

      # Quit
      "Mod+Shift+E".action.quit = {};
      "Ctrl+Alt+Delete".action.quit = {};

      # Power off monitors
      "Mod+Shift+P".action.power-off-monitors = {};
    };
  };

  programs.niri.settings.recent-windows = {
    debounce-ms = 750;
    open-delay-ms = 150;
    highlight = {
      active-color = "#999999ff";
      urgent-color = "#ff9999ff";
      padding = 30;
      corner-radius = 0;
    };
    previews = {
      max-height = 480;
      max-scale = 0.5;
    };
    binds = {
      "Super+Tab".action.next-window = {};
      "Super+Shift+Tab".action.previous-window = {};
    };
  };
}
