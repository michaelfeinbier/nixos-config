{ config, ... }:
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
          email = config.me.email;
          name = config.me.fullname;
        };
      };
      
      ignores = [ "*~" "*.swp" ];
    };
    lazygit.enable = true;
  };

}
