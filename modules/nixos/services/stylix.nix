{ pkgs, config, inputs, self, homeModules, ... } : {

  # home.packages = with pkgs; [
  #   base16-schemes
  # ];

  imports = [
  ];

  stylix = { 
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    enable = true;
    image = "${inputs.self}/files/wallpaper/catppuccin_triangle.png";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };

    polarity = "dark";
  };

  # Per application
  
}