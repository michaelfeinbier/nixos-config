{
  description = "A home-manager template providing useful tools & settings for Nix-based development";

  inputs = {
    # Principle inputs (updated by `nix run .#update`)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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

    hyprswitch.url = "github:h3rmt/hyprswitch/release";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-virtual-desktops.url = "github:levnikmyskin/hyprland-virtual-desktops";
    hyprland-virtual-desktops.inputs.hyprland.follows = "hyprland";
    hardware.url = "github:nixos/nixos-hardware";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    astal.url = "github:aylur/astal";
    ags.url = "github:aylur/ags";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # non flakes
    aesthetic-wallpapers.url = "github:D3Ext/aesthetic-wallpapers";
    aesthetic-wallpapers.flake = false;
  };

  # Wired using https://nixos-unified.org/autowiring.html
  outputs = inputs:
    inputs.nixos-unified.lib.mkFlake
      { inherit inputs; root = ./.; };

  # Wired with flakeParts
  # outputs = inputs@{ self, ... }:
  #   inputs.flake-parts.lib.mkFlake { inherit inputs; } {
  #     systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
  #     imports = (with builtins;
  #       map
  #         (fn: ./modules/flake/${fn})
  #         (attrNames (readDir ./modules/flake)));

  #     perSystem = { lib, system, ... }: {
  #       # Make our overlay available to the devShell
  #       # "Flake parts does not yet come with an endorsed module that initializes the pkgs argument.""
  #       # So we must do this manually; https://flake.parts/overlays#consuming-an-overlay
  #       _module.args.pkgs = import inputs.nixpkgs {
  #         inherit system;
  #         #overlays = lib.attrValues self.overlays;
  #         overlays = [
  #           inputs.nix-vscode-extensions.overlays.default
  #         ];
  #         config.allowUnfree = true;
  #       };
  #     };
  #   };
}
