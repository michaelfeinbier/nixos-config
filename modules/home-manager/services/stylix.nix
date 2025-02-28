{ pkgs, config, ... }:

{
  stylix = {
    enable = true;
    autoEnable = false;
    image = config.wallpaper;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    polarity = "dark";

    # Configuration for apps
    targets = {
      gtk.enable = true;
      #nixos-icons.enable = true;
      hyprland.enable = true;
      hyprpaper.enable = true;
      kitty.enable = true;
      swaync.enable = true;
      waybar.enable = true;
      waybar.addCss = false;
      rofi.enable = true;

      # neeeee
      #vscode.enable = true;
    };
  };

}
