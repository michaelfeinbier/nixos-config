{ pkgs, ... }:
{
  # Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-mono
    roboto
    dejavu_fonts
  ];
}
