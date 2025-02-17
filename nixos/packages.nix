{ config, pkgs, ... }:

{
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

   environment.systemPackages = with pkgs;[
    git
    _1password-gui
    _1password-cli
    vscode
    vim
    kitty

    waybar
  ];

  # Hyprland 

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

  };
}