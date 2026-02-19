{ config, lib, pkgs, ... }:

{
  services.wlsunset = {
    enable = true;
    gamma = 0.9;

    latitude =  51.23;
    longitude = 6.78;

    temperature = {
      day = 5000;
      night = 3000;
    };

  };
}