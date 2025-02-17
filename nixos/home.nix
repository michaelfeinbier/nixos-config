{ config, pkgs, home-manager, ... }:

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.michael = { pkgs, ... }: {

  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;
  };

    programs.git = {
      enable = true;
      userEmail = "michael@feinbier.net";
      userName = "Michael Feinbier";
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    home.stateVersion = "24.11";
  };
}