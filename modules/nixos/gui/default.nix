{
  imports = [
    #./gnome.nix
    ./hyprland.nix
  ];
  services.xserver.enable = true;
}
