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
    (self + /modules/home/desktop/gtk.nix)
    (self + /modules/home/desktop/qt.nix)
    (self + /modules/home/desktop/xdg.nix)
    (self + /modules/home/services/cliphist.nix)
    (self + /modules/home/services/wlsunset.nix)
    (self + /modules/home/services/hypridle.nix)
    (self + /modules/home/programs/noctalia)
    # "${nhModules}/programs/swappy"
    # "${nhModules}/services/hypridle"
    # "${nhModules}/services/kanshi"
  ];

  # Consistent cursor theme across all applications.
  # When stylix is enabled, cursor is managed by stylix instead.
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = lib.mkDefault config.gtk.cursorTheme.package;
    name = lib.mkDefault config.gtk.cursorTheme.name;
    size = lib.mkDefault 24;
  };
}