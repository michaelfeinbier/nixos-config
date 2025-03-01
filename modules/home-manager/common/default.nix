{
  userConfig,
  pkgs,
  homeModules,
  lib,
  self,
  ...
}:
{
  # Default programms and settings
  imports = [
    "${homeModules}/programs/git.nix"
    "${homeModules}/programs/brave.nix"
    "${homeModules}/programs/vscode.nix"
    "${homeModules}/programs/zsh.nix"
    "${homeModules}/programs/alacritty.nix"
    "${homeModules}/programs/fastfetch.nix"
    "${homeModules}/programs/starship.nix"
    "${homeModules}/programs/mangohud.nix"
    "${homeModules}/misc/wallpaper.nix"

  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.isDarwin then "/Users/${userConfig.name}" else "/home/${userConfig.name}";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    vim
    dua
    htop
    nixfmt-rfc-style
    _1password-gui
    _1password-cli
    pavucontrol
    tela-icon-theme
    gnome-tweaks
    bibata-cursors
  ];

}
