# Gaming feature - loads when features.gaming.enable = true
{ config, lib, ... }:

let
  cfg = config.myConfig.features.gaming;
in
{
  imports = [
    ./discord.nix
    ./mangohud.nix
  ];
}
