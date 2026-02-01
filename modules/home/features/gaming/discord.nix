{ pkgs, lib, config, ... }:

let
  cfg = config.me.features.gaming;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
