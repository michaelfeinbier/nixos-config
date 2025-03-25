{flake, ...}:
let
  inherit (flake) config inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{
  # Make Linux behave like MacOS here
  imports = [
    inputs.xremap.nixosModules.default
  ];

  services.xremap = {
    enable = true;
    withGnome = true;
    #withHypr = true;
    serviceMode = "user";
    userName = me.username;

    # loading the conf from https://github.com/petrstepanov/gnome-macos-remap-wayland
    yamlConfig = builtins.readFile "${inputs.xremap-wayland}/config.yml";
  };
}