{ flake, lib, config, ... }:

let
  cfg = config.me.features.development;
in
{
  imports = [
    flake.inputs.nixvim.homeManagerModules.nixvim
  ];

  config = lib.mkIf cfg.enable {
    programs.nixvim = import ./nixvim.nix // {
      enable = true;
    };
  };
}
