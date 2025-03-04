{ pkgs, inputs, ... }:
{
  # From https://github.com/AlexNabokikh/nix-config/blob/master/modules/nixos/desktop/hyprland/default.nix

  # GLOBAL CONFIGURATION

  # Call dbus-update-activation-environment on login
  #services.xserver.updateDbusEnvironment = true;

  # # Enables support for Bluetooth
  # hardware.bluetooth = {
  #   enable = true;
  #   powerOnBoot = true;
  # };

  # # Enable Bluetooth support
  # services.blueman.enable = true;

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    # Whether to enable XWayland
    xwayland.enable = true;

    withUWSM = true;

    # Maybe this only works when imported as flake
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.uwsm = {
    enable = true;
    waylandCompositors.hyprland = {
      prettyName = "Hyprland";
    };
  };

  # Enable security services
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  security.pam.services = {
    hyprlock = { };
    gdm.enableGnomeKeyring = true;
  };

  # Enable Ozone Wayland support in Chromium and Electron based applications
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    XCURSOR_SIZE = "24";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  # List of Hyprland specific packages
  environment.systemPackages = with pkgs; [
    file-roller # archive manager
    gnome-calculator
    gnome-pomodoro
    gnome-text-editor
    loupe # image viewer
    nautilus # file manager
    seahorse # keyring manager
    totem # Video player

    kitty
    waybar
    rofi-wayland
    # swaynotificationcenter via package now
    inputs.hyprswitch.packages.x86_64-linux.default
    hyprpaper
    hyprsunset
    nwg-dock-hyprland
  ];
}
