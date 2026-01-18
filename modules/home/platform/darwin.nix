# macOS (Darwin) specific home-manager configuration
{ pkgs, lib, config, ... }:

{
  config = lib.mkIf pkgs.stdenv.isDarwin {
    # macOS-specific settings
    # Homebrew Cask apps can be managed here if needed

    # macOS uses a different home directory structure
    # This is already handled in michael.nix via lib.mkDefault
  };
}
