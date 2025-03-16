{ config, pkgs, ... }:
let 
  defaultWindowConfigs = [
    # Gaming Stuff
    "discord.desktop:2"
    "steam.desktop:2"
  ];
in
{

  # GNOME extension config ... this is additonal gconf settings to whats in ../gtk.nix
  dconf.settings."org/gnome/shell" = {
    disable-user-extensions = false;

    # Enablement is not enough, the extension must be installed
    enabled-extensions = with pkgs.gnomeExtensions; [
      blur-my-shell.extensionUuid
      pano.extensionUuid
      dash-to-dock.extensionUuid
      search-light.extensionUuid
      workspace-buttons-with-app-icons.extensionUuid
      appindicator.extensionUuid
      emoji-copy.extensionUuid
      auto-move-windows.extensionUuid
    ];
  };

  # Enable the extensions
  home.packages = with pkgs.gnomeExtensions; [
    blur-my-shell
    pano
    dash-to-dock
    search-light
    workspace-buttons-with-app-icons
    appindicator
    emoji-copy
    auto-move-windows
  ];

  # Configure extenions
  dconf.settings = {
    "org/gnome/shell/extensions/pano" = {
      global-shortcut = "<Alt><Super>c";
      send-notification-on-copy = false;
      keep-search-entry = false;
      play-audio-on-copy = false;
      show-indicator = false;
      session-only-mode = true; # clear history on restart / logout
    };
    "org/gnome/shell/extensions/appindicator" = {
      icon-opacity = 100;
      legacy-tray-enabled = false;
      tray-pos = "right";
    };
    "org/gnome/shell/extensions/workspace-buttons-with-app-icons" = {
      wsb-active-button-background-color = config.lib.stylix.colors.withHashtag.base04;
      wsb-inactive-button-background-color = config.lib.stylix.colors.withHashtag.base02;

      wsb-active-workspace-number-background-color = config.lib.stylix.colors.withHashtag.base04;
      wsb-inactive-workspace-number-background-color = config.lib.stylix.colors.withHashtag.base02;

      wsb-button-spacing = "2";
      wsb-desaturate-icons = true;
      wsb-icon-size = 22;
      wsb-icon-spacing = 5;
      wsb-show-workspace-number = true;
    };
    "org/gnome/shell/extensions/emoji-copy" = {
      always-show = false;
    };

    "org/gnome/shell/extensions/auto-move-windows" = {
      application-list = defaultWindowConfigs;
    };
  };
}
