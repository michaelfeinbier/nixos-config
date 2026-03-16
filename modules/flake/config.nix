{lib, ...}:
# Global configuration for this repo
#
# See ./modules/flake-parts/config-module.nix for schema
{
  me = {
    username = "michael";
    fullname = "Michael Feinbier";
    email = "mf@tiberianmaster.net";
    sshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDaFHBcj6B1u0SpHEatrJ3RExPPhD88mCO9xHmF09rZQ";
    # see https://tinted-theming.github.io/tinted-gallery/
    color = "ciapre";
    # see https://alexandrosliaskos.github.io/Awesome_Wallpapers/
    wallpaper = "${inputs.aesthetic-wallpapers}/images/saturn-rings.jpg"
  };
}
