# GNOME-specific configuration
{ config, lib, ... }:

let
  cfg = config.me.features.gui;
in
{
  imports = [
    ./extensions.nix
    ./keybindings.nix
  ];
}
