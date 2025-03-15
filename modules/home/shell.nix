{ flake, pkgs, lib, ... }:
let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{

  programs = {
    bash.enable = false;

    # For macOS's default shell.
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      envExtra = ''
        # Custom ~/.zshenv goes here
      '';
      profileExtra = ''
        # Custom ~/.zprofile goes here
      '';
      loginExtra = ''
        # Custom ~/.zlogin goes here
      '';
      logoutExtra = ''
        # Custom ~/.zlogout goes here
      '';
      initExtra = ''
        fastfetch
      '';
    };

    # Type `z <pat>` to cd to some directory
    zoxide.enable = true;

    # Better shell prmot!
    starship = {
      enable = true;

      # load from rawfile
      settings = (builtins.fromTOML (builtins.readFile "${self}/raw-files/starship.toml"));

      # settings = {
      #   username = {
      #     style_user = "blue bold";
      #     style_root = "red bold";
      #     format = "[$user]($style) ";
      #     disabled = false;
      #     show_always = true;
      #   };
      #   hostname = {
      #     ssh_only = false;
      #     ssh_symbol = "🌐 ";
      #     format = "on [$hostname](bold red) ";
      #     trim_at = ".local";
      #     disabled = false;
      #   };
      # };
    };
  };

  # Fastfetch
  programs.fastfetch = {
    enable = true;
    # settings = {
    #   logo = {
    #     source = "nixos_small";
    #     padding = {
    #       right = 1;
    #     };
    #   };
    # };
  };
}
