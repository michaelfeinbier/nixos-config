{
  config,
  lib,
  nhModules,
  flake,
  ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    (self + /modules/home/gui/gtk.nix)
    (self + /modules/home/gui/qt.nix)
    (self + /modules/home/gui/xdg.nix)
    (self + /modules/home/programs/noctalia)
    # "${nhModules}/programs/swappy"
    # "${nhModules}/services/hypridle"
    # "${nhModules}/services/kanshi"
  ];

  # Consistent cursor theme across all applications.
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = config.gtk.cursorTheme.package;
    name = config.gtk.cursorTheme.name;
    size = 24;
  };
}