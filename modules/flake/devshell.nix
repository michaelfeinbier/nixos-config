{
  perSystem = { pkgs, inputs', lib, ... }: {
    devShells.default = pkgs.mkShell {
      name = "nixos-unified-template-shell";
      meta.description = "Shell environment for modifying this Nix configuration";
      packages = with pkgs; [
        just
        nixd
      ] ++ lib.optionals pkgs.stdenv.isLinux [
        inputs'.ags.packages.default
      ];
    };
  };
}
