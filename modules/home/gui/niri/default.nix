{
  imports = [
    ../wayland-common
  ];

  xdg.configFile = {
    "niri/config.kdl" = {
      source = ./config.kdl;
    };
  };
}