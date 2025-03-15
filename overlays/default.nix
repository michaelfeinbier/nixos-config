{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  packages = self + /packages;
in
{

  final: prev: {
  #nuenv = (inputs.nuenv.overlays.nuenv self super).nuenv;
  #fuckport = self.callPackage "${packages}/fuckport.nix" { };

  is-this-even-reead ? seems like not
  };
  }
