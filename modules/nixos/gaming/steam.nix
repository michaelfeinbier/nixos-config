{ flake, pkgs, ... }:
let
  inherit (flake) config inputs;
  inherit (inputs) self;

  # Prefix configs from https://github.com/Skademaskinen/Archerus/blob/main/modules/nixosModules/gaming/default.nix
  prefixConfig = [
    {
      name = "gamemode";
      package = pkgs.gamemode;
      path = "${pkgs.gamemode}/bin/gamemoderun";
      priority = 1;
    }
    {
      name = "gamescope";
      package = pkgs.gamescope;
      path = "${pkgs.gamescope}/bin/gamescope";
      arguments = [ "-W" "3840" "-H" "2160" "-w" "3840" "-h" "2160" "--adaptive-sync" "--mangoapp" "--force-grab-cursor" "-s" "2" "-e" "-f" "--" ];
      priority = 3;
    }
  ];
in
{

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = false;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
      # prefixConfig
      # Broken - maybe https://github.com/kimjongbing/nix-proton-cachyos/pull/12 will fix it
      # inputs.nix-proton-cachyos.packages.${system}.proton-cachyos
    ];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = false; 
  };
  
  # supposed to fix issues with gamescope
  programs.nix-ld = {
    enable = false;
    libraries = pkgs.steam-run.args.multiPkgs pkgs;
  };

  # Try capSysNice with a different approach
  # https://github.com/NixOS/nixpkgs/issues/351516
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-cpp;
    extraRules = [
      {
        "name" = "gamescope";
        "nice" = -20;
      }
    ];
  };
}
