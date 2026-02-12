{
  imports = [
    ../wayland-common
  ];

  xdg.configFile = {
    "niri/config.kdl".source = ./config.kdl;
    "niri/io.kdl".source = ./configs/io.kdl;
    "niri/layout.kdl".source = ./configs/layout.kdl;
    "niri/windows.kdl".source = ./configs/windows.kdl;
    "niri/binds.kdl".source = ./configs/binds.kdl;
  };
}