{ lib, ... }:

# Decided for Niri now
{
  imports = [
    ./wayland-common
    ./niri
  ];
}
