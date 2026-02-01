{ flake, ... }:
let
  inherit (flake.config) me;
in
{
  home.shellAliases = {
    g = "git";
    lg = "lazygit";
  };

  # https://nixos.asia/en/git
  programs = {
    git = {
      enable = true;
      settings = {
        alias = {
          ci = "commit";
        };
        user = {
          email = me.email;
          name = me.fullname;
        };
      };
      
      ignores = [ "*~" "*.swp" ];
    };
    lazygit.enable = true;
  };

}
