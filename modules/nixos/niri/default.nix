{ pkgs, flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    (self + /modules/nixos/desktop/wayland-common.nix)
  ];

  # Enable Niri
  programs.niri.enable = true;

  # Enable Xwayland
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];
}