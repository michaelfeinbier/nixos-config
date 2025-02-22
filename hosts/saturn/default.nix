{
  pkgs,
  self,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    #./packages.nix
  ];

  networking.hostName = "saturn"; # Define your hostname.
}
