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

  stylix = {
    enable = true;
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-pale.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";

    # select one from https://alexandrosliaskos.github.io/Awesome_Wallpapers/
    image = "${inputs.aesthetic-wallpapers}/images/lake.jpg";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Ice";
      size = 24;
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
        package = pkgs.noto-fonts-emoji;
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
