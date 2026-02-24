{ config, lib, pkgs, ... }:

{
  # WL-Sunset is unused, using the location setting of noctalia shell instead
  services.wlsunset = {
    enable = false;
    gamma = 0.9;

    latitude =  51.23;
    longitude = 6.78;

    temperature = {
      day = 5000;
      night = 3500;
    };
  };
}