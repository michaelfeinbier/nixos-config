# Home-manager module entry point
# Imports options, profiles, core modules, features, and platform-specific configs
{ ... }:

{
  imports = [
    # Feature flag and profile option definitions
    ./options.nix

    # Profile presets (minimal, desktop, server)
    ./profiles

    # Core modules - always loaded
    ./core

    # Feature modules - conditionally loaded based on feature flags
    ./features/gui
    ./features/development
    ./features/gaming
    ./features/productivity

    # Platform-specific adjustments
    ./platform/linux.nix
    ./platform/darwin.nix
  ];
}
