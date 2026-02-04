{ pkgs, lib, ... }:

# Discord - use Homebrew cask on macOS
{
  home.packages = lib.optionals (!pkgs.stdenv.isDarwin) (with pkgs; [
    discord
  ]);
}
