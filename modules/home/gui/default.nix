{ lib, ... }:

# Linux-only GUI modules (Hyprland, GNOME, COSMIC, GTK)
# These modules internally use mkIf to guard Linux-specific settings
{
  imports = [
    #./hyprland
    #./cosmic
    #./gnome  # Kept but not imported
    #./gtk.nix
  ];
}
