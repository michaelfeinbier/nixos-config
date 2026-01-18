# Linux-specific home-manager configuration
{ pkgs, lib, config, ... }:

{
  config = lib.mkIf pkgs.stdenv.isLinux {
    # Linux-specific settings can go here
    # Most Linux-specific settings are already handled conditionally in other modules
  };
}
