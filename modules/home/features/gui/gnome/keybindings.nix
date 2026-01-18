{ lib, config, ... }:

let
  cfg = config.myConfig.features.gui;
in
{
  config = lib.mkIf cfg.enable {
    dconf.settings."org/gnome/desktop/wm/keybindings" = {
      close = [ "<Control>q" ];
    };

    # Disable overview key - interferes with + ... combinations
    dconf.settings = {
      "org/gnome/mutter" = {
        overlay-key = "''";
      };

      # Minimize all windows
      "org/gnome/desktop/wm/keybindings" = {
        minimize-all = [ "''" ];
        minimize = [ "''" ];
        show-desktop = [ "<Control>d" ];

        # + Tab to switch windows
        switch-applications = [ "<Control>Tab" ];
        switch-applications-backward = [ "<Shift><Control>Tab" ];
        switch-group = [ "<Control>grave" ];
        switch-group-backward = [ "<Shift><Control>grave" ];

        # Switch workspaces
        switch-to-workspace-left = "['<Super>Left']";
        switch-to-workspace-right = "['<Super>Right']";
      };

      "org.gnome.shell.keybindings" = {
        toggle-message-tray = "[]";
        toggle-overview = [ "LaunchA" ];
        toggle-application-view = [ "<Primary>space" "LaunchB" ];

        # Screenshots
        screenshot = [ "<Shift><Control>3" ];
        show-screenshot-ui = [ "<Shift><Control>4" ];
        screenshot-window = [ "<Shift><Control>5" ];
      };
    };
  };
}
