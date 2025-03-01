{ pkgs, ... }:
{
  #programs.warp-terminal.enable = true;
  home.packages = with pkgs; [
    warp-terminal
  ];
}
