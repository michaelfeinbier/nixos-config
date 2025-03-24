{flake, ...}:
let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{
  # Make Linux behave like MacOS here
  import = [
    inputs.xremap-flake.homeManagerModules.default
  ]
}