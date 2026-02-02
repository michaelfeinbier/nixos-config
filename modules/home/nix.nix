{ config, pkgs, lib, ... }:
{
  # To use the `nix` from `inputs.nixpkgs` on templates using the standalone `home-manager` template

  # `nix.package` is already set if on `NixOS` or `nix-darwin`.
  # TODO: Avoid setting `nix.package` in two places. Does https://github.com/juspay/nixos-unified-template/issues/93 help here?
  nix.package = lib.mkDefault pkgs.nix;
  home.packages = [
    config.nix.package
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.substituters = [ 
    "https://attic.xuyh0120.win/lantian" 
    "https://cache.garnix.io"
  ];
  nix.settings.trusted-public-keys = [ 
    "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" 
    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
  ];

}
