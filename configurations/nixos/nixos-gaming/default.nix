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
    #flake.inputs.stylix.nixosModules.stylix
    self.nixosModules.default
    self.nixosModules.sound
    self.nixosModules.xremap
    self.nixosModules.niri
    self.nixosModules.gaming
    self.nixosModules.terminal
    self.nixosModules._1password
    inputs.hardware.nixosModules.common-cpu-intel
    #inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd
    ./configuration.nix
  ];

  # Enable home-manager for our user
  home-manager.users."${me.username}" = {
    imports = [ (self + /configurations/home/${me.username}.nix) ];
  };
  home-manager.backupFileExtension = "bckp";

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
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
