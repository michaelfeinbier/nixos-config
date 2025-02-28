{ pkgs, ... }:

{
  stylix = {
    enable = true;
    autoEnable = false;
    image = ../wallpaper/path-to-heaven.jpg;
    polarity = "dark";

    # Configuration for apps
    targets = {
      gtk.enable = true;
      hyprland.enable = true;
      hyprpaper.enable = true;
      kitty.enable = true;
      swaync.enable = true;
      waybar.enable = true;
      rofi.enable = true;

      # neeeee
      #vscode.enable = true;
    };
  };

}
