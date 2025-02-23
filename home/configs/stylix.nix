{pkgs, ... }:

{
  stylix = {
    enable = false;
    #image = ../wallpaper/path-to-heaven.jpg;
    image = pkgs.fetchurl {
    url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
    sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
  };
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
      vscode.enable = true;
    };
  };

}
