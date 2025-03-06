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
    "${homeModules}/desktop/wallpaper.nix"
    "${homeModules}/programs/git.nix"
    "${homeModules}/programs/brave.nix"
    "${homeModules}/programs/vscode.nix"
    "${homeModules}/programs/zsh.nix"
    "${homeModules}/programs/alacritty.nix"
    "${homeModules}/programs/fastfetch.nix"
    "${homeModules}/programs/starship.nix"
    "${homeModules}/programs/mangohud.nix"
    "${homeModules}/misc/gtk.nix"
  ];

  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.isDarwin then "/Users/${userConfig.name}" else "/home/${userConfig.name}";
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nnn # terminal file manager
    eza # ls replacement
    fzf # fuzzy finder
    dua # disk usage
    vim
    git

    dnsutils
    ldns
    nmap

    which
    tree
    nixfmt-rfc-style
    _1password-gui
    _1password-cli
    pavucontrol
    tela-icon-theme
    bibata-cursors
    cliphist
    webcord-vencord
  ];

}
