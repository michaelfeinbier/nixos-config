{ userConfig, pkgs, ... }:
{
  # Default programms and settings
  imports = [
    ../programs/git.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "${userConfig.username}";
    homeDirectory =
      if pkgs.stdenv.isDarwin then "/Users/${userConfig.name}" else "/home/${userConfig.name}";
  };

  home.packages = with pkgs; [
    git
    vim
    nixfmt-rfc-style
    _1password-gui
    _1password-cli
  ];

}
