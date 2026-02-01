# Import and apply the global configuration values
{ ... }:
{
  imports = [
    ./config-module.nix
  ];

  config = import ../../config.nix;
}
