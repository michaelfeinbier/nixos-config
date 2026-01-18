{ pkgs, lib, config, ... }:

let
  cfg = config.myConfig.features.gui;
in
{
  config = lib.mkIf cfg.enable {
    # GUI packages
    home.packages = with pkgs; [
      warp-terminal
      vlc
      cider-2
      nextcloud-client
      obsidian
    ];
  };
}
