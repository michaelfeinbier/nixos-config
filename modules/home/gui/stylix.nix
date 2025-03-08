{
  pkgs,
  flake,
  ...
}:

let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    enable = true;
    image = ../../../files/wallpaper/catppuccin_triangle.png;
    #image = "${inputs.self}/files/wallpaper/catppuccin_triangle.png";
  #   image = pkgs.fetchurl {
  #   url = "https://www.pixelstalk.net/wp-content/uploads/2016/05/Epic-Anime-Awesome-Wallpapers.jpg";
  #   sha256 = "enQo3wqhgf0FEPHj2coOCvo7DuZv+x5rL/WIo4qPI50=";
  # };
    #image = ~/.local/share/backgrounds/misc/comfy-home.png;
    #image = config.wallpaper;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };

    polarity = "dark";
  };

  # Per application
  stylix.targets.waybar = {
    enable = true;
    enableCenterBackColors = true;
    addCss = false;
  };

  stylix.targets.vscode.enable = false;
}
