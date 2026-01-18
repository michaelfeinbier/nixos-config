# Top-level flake glue to get our configuration working
{ inputs, ... }:

let
  # Helper to create standalone home-manager configuration
  mkHomeConfig = { system, profile, extraModules ? [ ] }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.nix-vscode-extensions.overlays.default
        ];
      };
      extraSpecialArgs = {
        flake = {
          inherit inputs;
          config = import ../../config.nix;
        };
      };
      modules = [
        ../../modules/home
        {
          myConfig.profiles.${profile} = true;
        }
        ({ pkgs, lib, ... }:
          let
            me = (import ../../config.nix).me;
          in
          {
            home.username = me.username;
            home.homeDirectory = lib.mkDefault (
              if pkgs.stdenv.isDarwin
              then "/Users/${me.username}"
              else "/home/${me.username}"
            );
            home.stateVersion = "24.11";
            home.shell.enableZshIntegration = true;
            nix.package = lib.mkDefault pkgs.nix;
            home.packages = [ pkgs.nix ];
          })
      ] ++ extraModules;
    };
in
{
  imports = [
    inputs.nixos-unified.flakeModules.default
    inputs.nixos-unified.flakeModules.autoWire
  ];

  # Explicit standalone home-manager configurations
  flake.homeConfigurations = {
    # Standalone Linux desktop configuration
    "michael@linux" = mkHomeConfig {
      system = "x86_64-linux";
      profile = "desktop";
    };

    # Standalone Linux server configuration
    "michael@server" = mkHomeConfig {
      system = "x86_64-linux";
      profile = "server";
    };

    # Standalone macOS configuration
    "michael@darwin" = mkHomeConfig {
      system = "aarch64-darwin";
      profile = "desktop";
    };
  };

  perSystem = { self', pkgs, ... }: {
    # For 'nix fmt'
    formatter = pkgs.nixpkgs-fmt;

    # Enables 'nix run' to activate.
    packages.default = self'.packages.activate;
  };
}
