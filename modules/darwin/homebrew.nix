# Homebrew integration for GUI apps not in nixpkgs
{ ... }:

{
  homebrew = {
    enable = true;

    # Update and cleanup on activation
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap"; # Remove unlisted casks/formulae
    };

    # Global settings
    global = {
      autoUpdate = false; # Don't auto-update in background
    };

    # Homebrew taps
    taps = [
      "homebrew/cask"
    ];

    # CLI tools (prefer nixpkgs when available)
    brews = [ ];

    # GUI applications
    casks = [
      "1password"
      "raycast"
      "rectangle"
    ];

    # Mac App Store apps (requires mas CLI)
    masApps = { };
  };
}
