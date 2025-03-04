{ pkgs, ... }:
{

  programs.rofi = {
    enable = true;
    font = "DejaVu 24";
    yoffset = -500;
    package = pkgs.rofi-wayland;
  };

  catppuccin.rofi.enable = true;
}
