{
  pkgs,
  config,
  ...
}:
{

  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    enable = true;
    #image = "${inputs.self}/files/wallpaper/catppuccin_triangle.png";
    #image = ~/.local/share/backgrounds/misc/comfy-home.png;
    image = config.wallpaper;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };

    polarity = "dark";
  };

  # Per application

}
