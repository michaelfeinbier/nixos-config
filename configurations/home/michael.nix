{ flake, pkgs, lib, config, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  imports = [
    self.homeModules.default
  ];

  # Enable desktop profile with all features
  myConfig.profiles.desktop = true;

  # Override specific features as needed
  myConfig.features.gaming.enable = true;

  # `nix.package` is already set if on `NixOS` or `nix-darwin`.
  nix.package = lib.mkDefault pkgs.nix;
  home.packages = [
    config.nix.package
  ];

  home.shell.enableZshIntegration = true;
  home.username = me.username;
  home.homeDirectory = lib.mkDefault "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${me.username}";
  home.stateVersion = "24.11";
}
