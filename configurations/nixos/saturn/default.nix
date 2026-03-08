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
    self.nixosModules.stylix
    self.nixosModules.default
    self.nixosModules.sound
    self.nixosModules.xremap
    self.nixosModules.niri
    self.nixosModules.gaming
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

  boot.kernelParams = [
    "nvidia-drm.fbdev=1"
    "split_lock_mitigate=0"
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
