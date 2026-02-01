{ pkgs
, lib
, config
, ...
}:
{
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

    #theme = {
      #name = lib.mkForce "Marble";
      #package = lib.mkForce pkgs.marble-shell-theme;
      #name = lib.mkDefault "Flat-Remix-GTK-Grey-Darkest";
      #package = lib.mkDefault pkgs.flat-remix-gtk;
      #package = pkgs.juno-theme;
    #};
    iconTheme = {
      #name = "Tela-ubuntu-dark";
      #package = pkgs.tela-icon-theme;
      name = "Zafiro-icons-Dark";
      package = pkgs.zafiro-icons;
    };
    #cursorTheme = lib.mkDefault {
      # managed via stylix
    #};

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
