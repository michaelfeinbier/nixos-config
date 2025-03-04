{ ... }:
{
  # Zsh shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {

      # rebuild home-manager
      rhm = "home-manager switch --flake /home/michael/nix-os-config#michael@saturn";

      # rebuild system
      rs = "sudo nixos-rebuild switch --flake /home/michael/nix-os-config#saturn";

      # eza
      ls = "eza --color=always --group-directories-first --icons";
      ll = "eza -la --icons --octal-permissions --group-directories-first";
      l = "eza -bGF --header --git --color=always --group-directories-first --icons";
      llm = "eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons";
      la = "eza --long --all --group --group-directories-first";
      lx = "eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons";

    };

    initExtra = ''
      fastfetch
      if uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
}
