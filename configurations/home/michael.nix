{ flake, pkgs, lib, config, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  imports = [
    self.homeModules.default
    inputs.zen-browser.homeModules.twilight
    inputs.catppuccin.homeModules.catppuccin
  ];

  # Note: nixpkgs.config.allowUnfree should be set at the system level
  # when using home-manager.useGlobalPkgs = true

  home.username = me.username;
  home.homeDirectory = lib.mkDefault "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${me.username}";
  home.stateVersion = "24.11";

  # Catppuccin theming
  catppuccin.flavor = lib.mkDefault "frappe";
  catppuccin.accent = lib.mkDefault "blue";
}
