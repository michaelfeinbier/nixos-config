{
  perSystem = { pkgs, inputs', ... }: {
    devShells.default = pkgs.mkShell {
      name = "nixos-unified-template-shell";
      meta.description = "Shell environment for modifying this Nix configuration";
      packages = with pkgs; [
        just
        nixd
        inputs'.ags.packages.default
      ];
    };
  };
}
