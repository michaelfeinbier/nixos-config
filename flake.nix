{
  description = "Michael's NixOS configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    hyprswitch.url = "github:h3rmt/hyprswitch/release";
    hyprland.url = "github:hyprwm/Hyprland";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    # Global catppuccin theme
    catppuccin.url = "github:catppuccin/nix";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # Nix Darwin (for MacOS machines)
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      systems,
      treefmt-nix,
      nix-homebrew,
      darwin,
      catppuccin,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      # Small tool to iterate over each systems
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});

      # Eval the treefmt modules from ./treefmt.nix
      treefmtEval = eachSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);

      # Define user configurations
      users = {
        michael = {
          email = "michael@feinbier.net";
          fullName = "Michael Feinbier";
          name = "michael";
        };
      };

      # Generate dynamic NixOS & Home-manager Config
      mkNixosConfiguration =
        hostname: username:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
            nixosModules = "${self}/modules/nixos";
          };
          modules = [
            ./hosts/${hostname}
            #catppuccin.nixosModules.catppuccin
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bckp";

              home-manager.users.${username}.imports = [
                ./home/${username}/${hostname}/default.nix
                #catppuccin.homeManagerModules.catppuccin
              ];
              home-manager.extraSpecialArgs = {
                inherit inputs outputs;
                userConfig = users.${username};
                homeModules = "${self}/modules/home-manager";
              };
            }
          ];
        };

      # Generate dynamic Mac OS darwin configs
      mkDarwinConfiguration =
        hostname: username:
        darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
          };
          modules = [
            ./hosts/${hostname}
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
          ];
        };

      mkHomeConfiguration =
        system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            inherit inputs outputs;
            userConfig = users.${username};
            homeModules = "${self}/modules/home-manager";
          };
          modules = [

            ./home/${username}/${hostname}
            #catppuccin.homeManagerModules.catppuccin
          ];
        };

    in
    {

      # for `nix fmt`
      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
      # for `nix flake check`
      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });

      darwinConfigurations = {
        # Billie Mac
        "michael-JN4T2CYH6X" = mkDarwinConfiguration "michael-JN4T2CYH6X" "michael";
      };

      nixosConfigurations = {
        # Saturn
        saturn = mkNixosConfiguration "saturn" "michael";
      };

      # is now part of the nixosConfiguration
      # homeConfigurations = {
      #   "michael@saturn" = mkHomeConfiguration "x86_64-linux" "michael" "saturn";
      # };
    };
}
