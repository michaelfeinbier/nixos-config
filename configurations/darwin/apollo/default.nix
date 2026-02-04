# Darwin configuration for apollo (macOS)
{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  imports = [
    self.darwinModules.default
  ];

  # System identity
  networking.hostName = "apollo";

  # Platform
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Primary user for user-specific system settings (homebrew, defaults, etc.)
  system.primaryUser = me.username;

  # Enable home-manager for our user
  home-manager.users."${me.username}" = {
    imports = [ (self + /configurations/home/${me.username}.nix) ];
  };

  # User configuration
  users.users."${me.username}" = {
    home = "/Users/${me.username}";
    shell = "/bin/zsh";
  };

  # System packages available globally
  environment.systemPackages = [ ];

  # Used for backwards compatibility
  system.stateVersion = 5;
}
