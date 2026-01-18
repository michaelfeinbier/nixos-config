# Core modules - always loaded regardless of profile
{ ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./direnv.nix
    ./gc.nix
    ./nix-index.nix
    ./packages.nix
  ];
}
