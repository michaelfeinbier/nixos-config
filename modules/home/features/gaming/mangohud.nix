{ lib, config, ... }:

let
  cfg = config.me.features.gaming;
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
