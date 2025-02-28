{
  userConfig,
  pkgs,
  homeModules,
  ...
}:
{
  # Default programms and settings
  imports = [
    "${homeModules}/programs/git.nix"
    "${homeModules}/programs/brave.nix"
    "${homeModules}/programs/vscode.nix"
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
    nixfmt-rfc-style
    _1password-gui
    _1password-cli
  ];

}
