{ config, pkgs,  ... }:

{

  imports = [
    ./programs/brave.nix
    ./configs/waybar.nix
  ];

    home.username = "michael";
    home.homeDirectory = "/home/michael";

    programs.git = {
      enable = true;
      userEmail = "michael@feinbier.net";
      userName = "Michael Feinbier";
    };

    # Gnome config
    # dconf = {
    #   enable = true;
    #   settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    #   settings."org/gnome/shell" = {
    #     disable-user-extensions = false;
    #     enabled-extensions = with pkgs.gnomeExtensions; [
    #       blur-my-shell.extensionUuid
    #       system-monitor.extensionUuid
    #       dash-to-dock.extensionUuid
    #     ];
    #   };
    # };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;


    fonts.fontconfig.enable = true;
    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" "FiraCode" "JetBrainsMono" "CascadiaCode" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
      ".config/hypr/hyprland.conf".source = ../dotfiles/hyprland.conf;
      ".config/hypr/animations.conf".source = ../dotfiles/animations.conf;
      ".config/hypr/nvidia.conf".source = ../dotfiles/nvidia.conf;
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/michael/etc/profile.d/hm-session-vars.sh
    #
    home.sessionVariables = {
      # EDITOR = "emacs";
    };


    home.stateVersion = "24.11";
}
