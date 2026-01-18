# Productivity feature - loads when features.productivity.enable = true
{ config, lib, ... }:

let
  cfg = config.myConfig.features.productivity;
in
{
  imports = [
    ./1password.nix
    ./browser.nix
  ];
}
