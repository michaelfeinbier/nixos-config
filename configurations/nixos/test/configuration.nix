{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    
  ];

  boot.tmp.cleanOnBoot = true;
  zramSwap.enable = true;
  networking.hostName = "nixos-test";
  networking.domain = "";
  services.openssh.enable = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  users.users.root.openssh.authorizedKeys.keys = [''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDaFHBcj6B1u0SpHEatrJ3RExPPhD88mCO9xHmF09rZQ'' ];
  system.stateVersion = "23.11";
}
