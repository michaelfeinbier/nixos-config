{ flake, pkgs, lib, ... }:
let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{
  perSystem = { pkgs, inputs', ... }: { };
}
