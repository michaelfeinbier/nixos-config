{ config, pkgs, ... }:

{
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

   environment.systemPackages = [
    pkgs.git
    pkgs._1password-gui
    pkgs._1password-cli
    pkgs.vscode
  ];
}