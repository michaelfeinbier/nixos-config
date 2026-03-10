{lib, ...}:
# Global configuration for this repo
#
# See ./modules/flake-parts/config-module.nix for schema
{
  me = {
    username = "michael";
    fullname = "Michael Feinbier";
    email = lib.mkDefault "mf@tiberianmaster.net";
    sshKey = lib.mkDefault "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDaFHBcj6B1u0SpHEatrJ3RExPPhD88mCO9xHmF09rZQ";
    color = "nord";
  };
}
