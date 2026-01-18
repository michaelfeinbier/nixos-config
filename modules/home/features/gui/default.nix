# GUI feature - loads when features.gui.enable = true
{ config, lib, ... }:

let
  cfg = config.myConfig.features.gui;
in
{
  imports = [
    ./gnome
    ./gtk.nix
    ./packages.nix
  ];

  # All GUI-related config is conditional on the feature being enabled
  config = lib.mkIf cfg.enable { };
}
