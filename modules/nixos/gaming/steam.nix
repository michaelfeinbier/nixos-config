{ flake, pkgs, ... }:
let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
      # Broken - maybe https://github.com/kimjongbing/nix-proton-cachyos/pull/12 will fix it
      #inputs.nix-proton-cachyos.packages.${system}.proton-cachyos
    ];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  
  # supposed to fix issues with gamescope
  programs.nix-ld = {
    enable = true;
    libraries = pkgs.steam-run.args.multiPkgs pkgs;
  };
}
