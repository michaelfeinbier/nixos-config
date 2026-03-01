{ pkgs
, flake
, config
, ...
}:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{

  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = true;

    # Pick themes from here: https://tinted-theming.github.io/tinted-gallery/
    # If you do not set this, stylix creates a color scheme from .image
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    # select one from https://alexandrosliaskos.github.io/Awesome_Wallpapers/
    # previous images: acrylic.jpg lake.jpg
    image = "${inputs.aesthetic-wallpapers}/images/lake.jpg";
    #image = config.lib.stylix.pixel "base0A";

    homeManagerIntegration = {
      autoImport = true;
      followSystem = true;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 18;
    };

    fonts = {
      serif = {
        #package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
        #name = "SFProDisplay Nerd Font";
        package = pkgs.texlivePackages.clearsans;
        name = "Clear Sans";
      };

      sansSerif = config.stylix.fonts.serif;

      monospace = {
        #use this after 24.11
        package = pkgs.nerd-fonts.jetbrains-mono;
        #package = pkgs.nerdfonts;
        
        name = "Jetbrains Mono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    opacity = {
      popups = .9;
      terminal = .9;

      # remove waybar background
      #desktop = 0.0;
    };

    polarity = "dark";
  };

  # Per application

  # own plymouth theme
  stylix.targets.plymouth.enable = false;

}
