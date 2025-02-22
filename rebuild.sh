
#export NIX_PATH=/home/michael/NixOS/nix-os-config/nixos/configuration.nix
#sudo nixos-rebuild --upgrade switch -I nixos-config=/home/michael/NixOS/nix-os-config/nixos/configuration.nix

#sudo nixos-rebuild --upgrade switch
sudo nixos-rebuild --flake . switch --impure --show-trace
