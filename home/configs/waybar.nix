{
  programs.waybar = {
    enable = true;

    style = ./waybar.css;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        reload_style_on_change = true;

        modules-left = [

        ];
        modules-center = [
          "hyprland/workspaces"
        ];

        modules-right = [
          "custom/notification"
          "tray"
          "cpu"
          "memory"
          "clock"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
            empty = "";
          };
          persistent-workspaces = {
            "*" = [1 2 3 4 ];
          };
        };

        "custom/notification" = {
          format = "";
          tooltip = false;
          on-click = "swaync-client -t -sw";
          escape = true;
        };

        cpu = {
          format = "󰻠 {usage}%";
          interval = 1;
          tooltip = true;
        };


    };
    };
  };
}
