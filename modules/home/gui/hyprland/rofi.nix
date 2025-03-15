{ pkgs, lib, home, ... }:

{

  programs.rofi = {
    enable = true;
    font = lib.mkDefault "DejaVu 24";
    yoffset = -500;
    package = pkgs.rofi-wayland;
  };

  home.file."./.local/share/rofi-theme" = {
    source = builtins.fetchGit {
      url = "https://github.com/adi1090x/rofi.git";
      rev = "9d27f13bc7aabeaf755a32fcc640713256f7433e";
    };
  };

  #catppuccin.rofi.enable = true;
}
 