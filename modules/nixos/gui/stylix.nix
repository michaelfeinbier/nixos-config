{
  pkgs,
  flake,
  config,
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
    #image = ./path-to-heaven.jpg;
    image = config.lib.stylix.pixel "base04";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };

    fonts = {
      serif = {
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };

      sansSerif = config.stylix.fonts.serif;

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "Jetbrains Mono Nerd Font";
      };
    };

    opacity = {
      popups = .9;
      terminal = .8;
    };

    polarity = "dark";
  };

  # Per application

  # own plymouth theme
  stylix.targets.plymouth.enable = false;
  
}
