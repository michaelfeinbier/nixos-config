{ pkgs, ... }:
{
  # Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-mono
    nerd-fonts.meslo-lg
    roboto
    dejavu_fonts
    texlivePackages.clearsans
  ];
}
