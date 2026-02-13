{ pkgs
, lib
, config
, ...
}:
lib.mkIf pkgs.stdenv.isLinux {
  # Consistent cursor theme across all applications.

  # Also set by stylix - this has no effect!
  # home.pointerCursor = lib.mkDefault {
  #   gtk.enable = true;
  #   #x11.enable = true;
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Original-Ice";
  #   size = 24;
  # };

  # GTK theme configuration
  gtk = {
    enable = true;
    colorScheme = "dark";
    gtk4.theme = config.gtk.theme;
    theme = {
      name = "catppuccin-${config.catppuccin.flavor}-${config.catppuccin.accent}-compact";
      package = pkgs.catppuccin-gtk.override {
        accents = [ config.catppuccin.accent ];
        variant = config.catppuccin.flavor;
        size = "compact";
      };
    };
    iconTheme = {
      name = "Tela-circle-dark";
      package = pkgs.tela-circle-icon-theme;
    };
    cursorTheme = {
      name = "Yaru";
      package = pkgs.yaru-theme;
      size = 24;
    };
    font = {
      name = "Open Sans";
      size = 11;
    };
    # gtk3 = {
    #   bookmarks = [
    #     "file://${config.home.homeDirectory}/Documents"
    #     "file://${config.home.homeDirectory}/Downloads"
    #     "file://${config.home.homeDirectory}/Pictures"
    #     "file://${config.home.homeDirectory}/Videos"
    #     "file://${config.home.homeDirectory}/Downloads/temp"
    #     "file://${config.home.homeDirectory}/Documents/repositories"
    #   ];
    # };
  };

  # Other dconf settings
  dconf.settings = {
    "org/gnome/shell" = {
      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "chromium-browser.desktop"
        "code.desktop"
        "steam.desktop"
      ];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkForce "prefer-dark";
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
