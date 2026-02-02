{ flake, pkgs, lib, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{

  environment.systemPackages = with pkgs; [
    tailscale
    ripgrep # Better `grep`
    fd
    sd
    tree
    gnumake
    dua
    vim
    gparted

    dnsutils # `dig`
    ldns
    nmap
    btop
    tealdeer # tldr
  ];
 }
