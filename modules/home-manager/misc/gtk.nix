{
  userConfig,
  pkgs,
  lib,
  ...
}:
{
  # Consistent cursor theme across all applications.
  home.pointerCursor = lib.mkDefault {
    gtk.enable = true;
    #x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  # GTK theme configuration
  gtk = {
    enable = true;

    theme = {
      name = lib.mkForce "Flat-Remix-GTK-Grey-Darkest";
      package = lib.mkForce pkgs.flat-remix-gtk;
      #package = pkgs.juno-theme;
    };
    iconTheme = {
      name = "Tela-dark";
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
      bookmarks = [
        "file:///home/${userConfig.name}/Documents"
        "file:///home/${userConfig.name}/Downloads"
      ];
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
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      #theme = "Juno";
      gtk-theme = "Flat-Remix-GTK-Grey-Darkest";
      icon-theme = "Tela-dark";
      #cursor-theme = "Bibata-Modern-Ice";
      #font-name = "Cantarell 11";
    };

    "org/gnome/nautilus/preferences" = {
      "default-folder-viewer" = "list-view";
      "migrated-gtk-settings" = true;
      "search-filter-time-type" = "last_modified";
      "search-view" = "list-view";
    };

    "org/gnome/desktop/wm/preferences" = {
      "button-layout" = lib.mkForce "";
      theme = "Flat-Remix-GTK-Grey-Darkest";
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
