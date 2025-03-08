# See /modules/nixos/* for actual settings
# This file is just *top-level* configuration.
{ flake, config, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self;
  inherit (flake.config) me;
in
{

  imports = [
    self.nixosModules.default
    self.nixosModules.gui
    inputs.hardware.nixosModules.common-cpu-intel
    #inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd
    #flake.inputs.stylix.nixosModules.stylix
    ./configuration.nix
  ];

  # Enable home-manager for our user
  home-manager.users."${me.username}" = {
    imports = [ (self + /configurations/home/${me.username}.nix) ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver = {
    #enable = true;
    videoDrivers = [ "nvidia" ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
