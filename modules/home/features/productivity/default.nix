# Productivity feature - loads when features.productivity.enable = true
{ config, lib, ... }:

let
  cfg = config.me.features.productivity;
in
{
  imports = [
    ./1password.nix
    ./browser.nix
  ];
}
