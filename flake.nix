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
    
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Global catppuccin theme
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia Shell
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Software inputs
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.flake-parts.follows = "flake-parts";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        # IMPORTANT: To ensure compatibility with the latest Firefox version, use nixpkgs-unstable.
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware";
    #stylix.url = "github:danth/stylix/release-24.11";
    #stylix.url = "github:danth/stylix";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    #apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    astal.url = "github:aylur/astal";
    ags.url = "github:aylur/ags";
    _1password-shell-plugins.url = "github:1Password/shell-plugins";

    # non flakes
    aesthetic-wallpapers.url = "github:D3Ext/aesthetic-wallpapers";
    aesthetic-wallpapers.flake = false;
    #xremap.url = "github:xremap/nix-flake";
    #xremap.inputs.nixpkgs.follows = "nixpkgs";
    #xremap-wayland.url = "github:petrstepanov/gnome-macos-remap-wayland";
    #xremap-wayland.flake = false;
  };

  # Wired using https://nixos-unified.org/autowiring.html
  outputs = inputs:
    inputs.nixos-unified.lib.mkFlake
      { inherit inputs; root = ./.; };
}
