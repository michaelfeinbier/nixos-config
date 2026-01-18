# Custom library functions for the nix configuration
{ lib, ... }:

{
  # Helper to conditionally import a module based on a feature flag
  mkFeatureModule = { enable, module }:
    lib.mkIf enable module;

  # Helper to get the home directory based on platform
  getHomeDirectory = { username, isDarwin }:
    if isDarwin then "/Users/${username}" else "/home/${username}";

  # Helper to merge platform-specific configurations
  mkPlatformConfig = { linuxConfig, darwinConfig, isDarwin }:
    if isDarwin then darwinConfig else linuxConfig;
}
