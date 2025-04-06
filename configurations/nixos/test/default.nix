# See /modules/nixos/* for actual settings
# This file is just *top-level* configuration.
{ flake, config, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{

  imports = [
    self.nixosModules.default
    ./configuration.nix
  ];

  nixos-unified.sshTarget = "root@65.21.105.226";

  # Enable home-manager for our user
  # home-manager.users."${me.username}" = {
  #   imports = [ (self + /configurations/home/${me.username}.nix) ];
  # };
}
