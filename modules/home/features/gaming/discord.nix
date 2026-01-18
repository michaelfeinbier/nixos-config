{ pkgs, lib, config, ... }:

let
  cfg = config.myConfig.features.gaming;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
