{...}: {
  # Zsh shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    shellAliases = {

      # rebuild home-manager
      rhm = "home-manager switch --flake /home/michael/nix-os-config";

      # rebuild system
      rs = "sudo nixos-rebuild switch --flake /home/michael/nix-os-config#michael@saturn";
    };  
  };
}