{ pkgs, flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    (self + /modules/nixos/desktop/wayland-common.nix)
    inputs.niri.nixosModules.niri
  ];

  # Enable Niri (unstable for recent-windows, maximize-window-to-edges, etc.)
  programs.niri.enable = true;
  programs.niri.package = inputs.niri.packages.${pkgs.system}.niri-unstable;

  # Enable Xwayland
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    wl-clipboard
  ];

  # Provide niri home-manager settings to all users on this machine
  home-manager.sharedModules = [
    (self + /modules/home/gui/niri/settings.nix)
  ];
}
