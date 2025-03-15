{ ... }:
{


  stylix.targets.waybar = {
    enable = true;
    enableCenterBackColors = true;
    enableLeftBackColors = true;
    enableRightBackColors = true;
    addCss = true;
  };

  # Install and configure waybar via home-manager module
  # FROM https://github.com/AlexNabokikh/nix-config/blob/7ceae47f38537077fce16bb353658eea112accdf/modules/home-manager/services/waybar/default.nix
  programs.waybar = {
    enable = true;
    settings = {
      sideBar = {
        layer = "top";
        output = "HDMI-A-2";
        position = "top";
        exclusive = true;
        passthrough = false;
        fixed-center = true;
        ipc = true;
        margin-top = 3;
        margin-left = 4;
        margin-right = 4;

        modules-right = [
          "clock"
          "custom/notification"
        ];
      };
      mainBar = {
        layer = "top";
        output = "HDMI-A-1";
        position = "top";
        exclusive = true;
        passthrough = false;
        fixed-center = true;
        ipc = true;
        margin-top = 3;
        margin-left = 4;
        margin-right = 4;

        modules-left = [
          "cpu"
          "temperature"
          "memory"
          #"backlight"
        ];

        modules-center = [
          "hyprland/workspaces"
          #"clock"
          #"custom/notification"
        ];

        modules-right = [
          #"hyprland/language"
          "tray"
          #"bluetooth"
          #"pulseaudio"
          "pulseaudio/slider"
          #"pulseaudio#microphone"
          #"battery"
          "clock"
          "custom/notification"
        ];

        backlight = {
          interval = 2;
          align = 0;
          rotate = 0;
          format = "{icon} {percent}%";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃝"
            "󰃠"
          ];
          icon-size = 10;
          on-scroll-up = "brightnessctl set +5%";
          on-scroll-down = "brightnessctl set 5%-";
          smooth-scrolling-threshold = 1;
        };

        battery = {
          interval = 60;
          align = 0;
          rotate = 0;
          full-at = 100;
          design-capacity = false;
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "<big>{icon}</big>  {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-full = "{icon} Full";
          format-alt = "{icon} {time}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          format-time = "{H}h {M}min";
          tooltip = true;
          tooltip-format = "{timeTo} {power}w";
        };

        bluetooth = {
          format = "";
          format-connected = " {num_connections}";
          tooltip-format = " {device_alias}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "Name: {device_alias}\nBattery: {device_battery_percentage}%";
          on-click = "blueman-manager";
        };

        clock = {
          format = "{:%d. %b %H:%M}";
          format-alt = " {:%H:%M   %Y, %d %B, %A}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        cpu = {
          format = "󰍛 {usage}%";
          interval = 1;
        };

        "hyprland/language" = {
          format = "{short}";
        };

        "hyprland/workspaces" = {
          all-outputs = false;
          format = "{icon}";
          format-icons = {
            # "1" = "";
            # "2" = "";
            # "3" = "";
            # "4" = "";
            # "5" =  "";
            active = "";
            default = "";
          };
          on-click = "activate";
          show-special = false;
          sort-by-number = true;
          persistent-workspaces = {
            "*" = 4;
            "HDMI-A-2" = 1;
          };

        };

        memory = {
          interval = 10;
          format = "󰾆 {used:0.1f}G";
          format-alt = "󰾆 {percentage}%";
          format-alt-click = "click";
          tooltip = true;
          tooltip-format = "{used:0.1f}GB/{total:0.1f}G";
          on-click-right = "foot --title btop sh -c 'btop'";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            default = [
              ""
              ""
              " "
            ];
          };
          on-click = "pavucontrol";
          on-scroll-up = "pamixer -i 5";
          on-scroll-down = "pamixer -d 5";
          scroll-step = 5;
          on-click-right = "pamixer -t";
          smooth-scrolling-threshold = 1;
          ignored-sinks = [ "Easy Effects Sink" ];
        };

        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };

        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}%";
          format-source-muted = "";
          on-click = "pavucontrol";
          on-click-right = "pamixer --default-source -t";
          on-scroll-up = "pamixer --default-source -i 5";
          on-scroll-down = "pamixer --default-source -d 5";
        };

        temperature = {
          interval = 10;
          tooltip = false;
          hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
          critical-threshold = 82;
          format-critical = "{icon} {temperatureC}°C";
          format = "󰈸 {temperatureC}°C";
        };

        tray = {
          spacing = 20;
        };

        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };
    style = ''
      * {
        font-weight: bold;
      }

      #waybar .module {
        border-radius: 5px;
        margin: 5px 5px 5px 5px;
        padding: 0 5px;
      }

      #waybar .modules-left .module,
      #waybar .modules-right .module {
        box-shadow: 0 0 4px @base00;
      }

      #workspaces button {
        margin: 0 2px;
      }

      #cpu,#temperature,#memory {
        min-width: 50px;
      }

      #custom-notification {
        background-color: @base0D;
        color: @base00;
      }

      #pulseaudio-slider slider {
          min-height: 0px;
          min-width: 0px;
          opacity: 0;
          background-color: @base04;
          border: none;
          box-shadow: none;
      }
      #pulseaudio-slider trough {
          min-height: 10px;
          min-width: 80px;
          border-radius: 5px;
          border: none;
          background-color: @base01;
      }
      #pulseaudio-slider highlight {
          min-width: 10px;
          border-radius: 5px;
          border: none;
          background-color: @base04;
      }
    '';
  };
}
