{ lib, ... }:

# Linux-only GUI modules (Hyprland, GNOME, GTK)
# These modules internally use mkIf to guard Linux-specific settings
{
  imports = [
    #./hyprland
    ./gnome
    ./gtk.nix
  ];
}
