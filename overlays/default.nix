{ flake, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  packages = self + /packages;
in {

final: prev: {
  #nuenv = (inputs.nuenv.overlays.nuenv self super).nuenv;
  #fuckport = self.callPackage "${packages}/fuckport.nix" { };
  base16-schemes = prev.stylix.overrideArgs(old: {
    src = prev.fetchFromGitHub {
      owner = "merrkry";
      repo = "stylix";
      rev = "fix-palette";
      #sha
    };
  }) 

  is-this-even-reead
};
}