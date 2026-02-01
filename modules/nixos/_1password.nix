{flake, pkgs, ...}:
let
  inherit (flake.config) me;
in
{
  #1Password here as well for authentication

  programs._1password = {
    enable = true;
  };
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ me.username ];
  };
}