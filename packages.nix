{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.lib.nixosSystem = {
  # #   #specialArgs = { inherit inputs; };
  # };

  environment.systemPackages = with pkgs; [
    git
    vim
    nixfmt-rfc-style

    # Gnome extension
    nautilus
    #gnomeExtensions.blur-my-shell
    #gnomeExtensions.dash-to-dock

    # all for hyprland
    kitty
    waybar
    rofi
    swaynotificationcenter
    nerdfonts
    inputs.hyprswitch.packages.x86_64-linux.default
    hyprpaper
    hyprsunset
  ];
}
