{ pkgs, lib, ... }:

# MangoHUD is Linux-only
lib.mkIf pkgs.stdenv.isLinux {
  programs.mangohud = {
    enable = true;
    settings = {
      vram = true;
      frametime = false;
      frame_timing = false;
      gamemode = true;
    };
  };

  catppuccin.mangohud.enable = true;
}
