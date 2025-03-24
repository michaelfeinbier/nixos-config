{flake, ...}:
let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{
  # Make Linux behave like MacOS here
  imports = [
    inputs.xremap.homeManagerModules.default
  ];

  services.xremap = {
    enable = true;
    withGnome = true;
    #withHypr = true;

    # loading the conf from https://github.com/petrstepanov/gnome-macos-remap-wayland
    yamlConfig = builtins.readFile "${inputs.xremap-wayland}/config.yml";
  };
}