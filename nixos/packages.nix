{ config, pkgs, ... }:

{
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    _1password-gui
    _1password-cli
    vscode
    vim
    nixfmt

    # Gnome extension
    gnomeExtensions.blur-my-shell
    gnomeExtensions.dash-to-dock

    kitty
    waybar
    rofi
  ];
}
