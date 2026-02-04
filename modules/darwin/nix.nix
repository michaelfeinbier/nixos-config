# Nix daemon configuration for macOS
{ flake, pkgs, ... }:

let
  inherit (flake.config) me;
in
{
  # nix-darwin manages the nix-daemon automatically when nix.enable is true
  nix = {
    enable = true;

    settings = {
      # Enable flakes and new nix command
      experimental-features = [ "nix-command" "flakes" ];

      # Trusted users who can modify binary caches
      trusted-users = [ "root" me.username ];

      # Accept flake config from remote flakes
      accept-flake-config = true;
    };

    # Automatic store optimization
    optimise.automatic = true;

    # Garbage collection - weekly cleanup
    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 2; Minute = 0; }; # Sunday 2am
      options = "--delete-older-than 30d";
    };

    # Use the nixpkgs from our flake
    nixPath = [ "nixpkgs=${pkgs.path}" ];
  };

  # Set the Nix package
  nixpkgs.config.allowUnfree = true;
}
