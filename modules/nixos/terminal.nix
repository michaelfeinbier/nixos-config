{ flake, pkgs, lib, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{

  environment.systemPackages = with pkgs; [
    ghostty
  ];
}