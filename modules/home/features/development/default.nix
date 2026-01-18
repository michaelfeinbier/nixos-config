# Development feature - loads when features.development.enable = true
{ config, lib, ... }:

let
  cfg = config.myConfig.features.development;
in
{
  imports = [
    ./packages.nix
    ./vscode.nix
    ./neovim
  ];
}
