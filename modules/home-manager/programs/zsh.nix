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
    };

    initExtra = ''
      fastfetch
      if uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
}
