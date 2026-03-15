# This is your nixos configuration.
# For home configuration, see /modules/home/*
{ flake, pkgs, lib, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  # These users can add Nix caches.
  nix.settings.trusted-users = [ "root" me.username ];

   nixpkgs = {
    config.allowUnfree = true;
   };

  imports = [
    ./nix.nix
    ./packages.nix
    ./fonts.nix

    # these go from toplevel
    # ./sound.nix
    # ./xremap.nix
  ];

  services.openssh.enable = true;

  # Passwordless sudo
  security.sudo.wheelNeedsPassword = false;

  # Docker configuration
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = true;
  virtualisation.docker.rootless.setSocketVariable = true;
  security.wrappers = {
    docker-rootlesskit = {
      owner = "root";
      group = "root";
      capabilities = "cap_net_bind_service+ep";
      source = "${pkgs.rootlesskit}/bin/rootlesskit";
    };
  };

  # Tailscale
  services.tailscale.enable = true;
}
