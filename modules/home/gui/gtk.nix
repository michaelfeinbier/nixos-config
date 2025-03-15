{
  pkgs,
  lib,
  config,
  ...
}:
{
  # Consistent cursor theme across all applications.
  home.pointerCursor = lib.mkDefault {
    gtk.enable = true;
    #x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Ice";
    size = 12;
  };

  # GTK theme configuration
  gtk = {
    enable = true;

    theme = {
      #name = lib.mkForce "Marble";
      #package = lib.mkForce pkgs.marble-shell-theme;
      #name = lib.mkDefault "Flat-Remix-GTK-Grey-Darkest";
      #package = lib.mkDefault pkgs.flat-remix-gtk;
      #package = pkgs.juno-theme;
    };
    iconTheme = {
      name = "Tela-ubuntu-dark";
      package = pkgs.tela-icon-theme;
    };
    # cursorTheme = {
    #   name = "Bibata-Modern-Ice";
    #   package = pkgs.bibata-cursors;
    #   size = 24;
    # };

    font = lib.mkDefault {
      name = "Sans";
      size = 11;
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };

  # GNOME Shell extensions
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
  ];

  # Other dconf settings
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "brave-browser.desktop"
        "code.desktop"
        "steam.desktop"
        "Alacritty.desktop"
      ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
    };

    # Configure extenions
    "org/gnome/shell/extensions/pano" = {
      global-shortcut = "<Alt><Super>c";
      send-notification-on-copy = false;
      keep-search-entry = false;
      show-indicator = false;
      session-only-mode = true; # clear history on restart / logout
    };
    "org/gnome/shell/extensions/appindicator" = {
      icon-opacity = 100;
      legacy-tray-enabled = false;
      tray-pos = "right";
    };
    "org/gnome/shell/extensions/workspace-buttons-with-app-icons" = {
      wsb-active-workspace-number-background-color = config.lib.stylix.colors.withHashtag.base0E;
      wsb-inactive-workspace-number-background-color = config.lib.stylix.colors.withHashtag.base0D;

      wsb-button-spacing = "2";
      wsb-desaturate-icons = true;
      wsb-icon-size = 22;
      wsb-icon-spacing = 5;
      wsb-show-workspace-number = false;
    };

    "org/gnome/nautilus/preferences" = {
      "default-folder-viewer" = "list-view";
      "migrated-gtk-settings" = true;
      "search-filter-time-type" = "last_modified";
      "search-view" = "list-view";
    };

    "org/gnome/desktop/wm/preferences" = {
      "button-layout" = lib.mkForce "";
    };

    "org/gnome/desktop/peripherals/mouse" = {
      "natural-scroll" = true;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      "show-hidden" = true;
    };

    "org/gtk/settings/file-chooser" = {
      "date-format" = "regular";
      "location-mode" = "path-bar";
      "show-hidden" = true;
      "show-size-column" = true;
      "show-type-column" = true;
      "sort-column" = "name";
      "sort-directories-first" = false;
      "sort-order" = "ascending";
      "type-format" = "category";
      "view-type" = "list";
    };

  };
}
