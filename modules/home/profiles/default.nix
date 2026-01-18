{ config, lib, ... }:

let
  cfg = config.myConfig;
in
{
  imports = [
    ./minimal.nix
    ./desktop.nix
    ./server.nix
  ];

  # Profile presets set feature flags
  config = lib.mkMerge [
    # Minimal profile: only core tools
    (lib.mkIf cfg.profiles.minimal {
      myConfig.features = {
        gui.enable = lib.mkDefault false;
        development.enable = lib.mkDefault false;
        gaming.enable = lib.mkDefault false;
        productivity.enable = lib.mkDefault false;
      };
    })

    # Desktop profile: full desktop experience
    (lib.mkIf cfg.profiles.desktop {
      myConfig.features = {
        gui.enable = lib.mkDefault true;
        development.enable = lib.mkDefault true;
        gaming.enable = lib.mkDefault false;
        productivity.enable = lib.mkDefault true;
      };
    })

    # Server profile: headless server
    (lib.mkIf cfg.profiles.server {
      myConfig.features = {
        gui.enable = lib.mkDefault false;
        development.enable = lib.mkDefault true;
        gaming.enable = lib.mkDefault false;
        productivity.enable = lib.mkDefault false;
      };
    })
  ];
}
