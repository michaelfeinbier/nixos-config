{
  description = "A home-manager template providing useful tools & settings for Nix-based development";

  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";

    # Software inputs
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.flake-parts.follows = "flake-parts";

    hardware.url = "github:nixos/nixos-hardware";
    xremap.url = "github:xremap/nix-flake";
    xremap.inputs.nixpkgs.follows = "nixpkgs";
    #stylix.url = "github:danth/stylix/release-24.11";
    stylix.url = "github:danth/stylix";

    #apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    astal.url = "github:aylur/astal";
    ags.url = "github:aylur/ags";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    _1password-shell-plugins.url = "github:1Password/shell-plugins";

    # non flakes
    aesthetic-wallpapers.url = "github:D3Ext/aesthetic-wallpapers";
    aesthetic-wallpapers.flake = false;
    xremap-wayland.url = "github:petrstepanov/gnome-macos-remap-wayland";
    xremap-wayland.flake = false;
  };

  # Wired using https://nixos-unified.org/autowiring.html
  outputs = inputs:
    inputs.nixos-unified.lib.mkFlake
      { inherit inputs; root = ./.; };
}
