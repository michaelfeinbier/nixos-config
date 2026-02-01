# Development feature - loads when features.development.enable = true
{ config, lib, ... }:

let
  cfg = config.me.features.development;
in
{
  imports = [
    ./packages.nix
    ./vscode.nix
    ./neovim
  ];
}
