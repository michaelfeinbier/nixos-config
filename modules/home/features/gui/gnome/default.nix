# GNOME-specific configuration
{ config, lib, ... }:

let
  cfg = config.myConfig.features.gui;
in
{
  imports = [
    ./extensions.nix
    ./keybindings.nix
  ];
}
