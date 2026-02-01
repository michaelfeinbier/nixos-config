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
  me.profiles.desktop = true;

  # Override specific features as needed
  me.features.gaming.enable = true;

  home.homeDirectory = lib.mkDefault "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${me.username}";
  home.stateVersion = "24.11";
}
