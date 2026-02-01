{ lib, config, ... }:

{
  options = {
    me = {

    # Feature flags for fine-grained control
    features = {
      gui = {
        enable = lib.mkEnableOption "GUI applications and desktop environment support";
      };

      development = {
        enable = lib.mkEnableOption "development tools and IDE configurations";
      };

      gaming = {
        enable = lib.mkEnableOption "gaming tools (Discord, MangoHud, etc.)";
      };

      productivity = {
        enable = lib.mkEnableOption "productivity applications (1Password, browser, etc.)";
      };
    };

    # Profile presets for convenient configuration
    profiles = {
      minimal = lib.mkEnableOption "minimal profile (core tools only)";
      desktop = lib.mkEnableOption "desktop profile (full desktop experience)";
      server = lib.mkEnableOption "server profile (headless server config)";
    };
  };
  };
}
