{ lib, config, ... }:

let
  cfg = config.myConfig.features.gaming;
in
{
  config = lib.mkIf cfg.enable {
    programs.mangohud = {
      enable = true;
      settings = {
        vram = true;
      };
    };
  };
}
