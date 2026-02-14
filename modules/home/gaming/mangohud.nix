{ pkgs, lib, ... }:

# MangoHUD is Linux-only
lib.mkIf pkgs.stdenv.isLinux {
  programs.mangohud = {
    enable = true;
    settings = {
      vram = true;
      frametime = 0;
      frame_timing = 0;
    };
  };

  catppuccin.mangohud.enable = true;
}
