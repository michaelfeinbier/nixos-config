# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, flake, ... }:
let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    plymouth = {
      enable = true;
      theme = lib.mkDefault "hexa_retro";
      themePackages = with pkgs; [
        # Select the cool ones from https://github.com/adi1090x/plymouth-themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "hexa_retro" "ironman" ];
        })
      ];
    };


    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };


  networking.hostName = "saturn"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "mac";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.michael = {
    isNormalUser = true;
    description = "Michael";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };
  # not sure why i need this .. but nix complains without it (even if in home-manager it is set)
  programs.zsh.enable = true;

  # Enable automatic login for the user.
  services.getty.autologinUser = "michael";
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "michael";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowAliases = false;
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default

    # GNOME 46: triple-buffering-v4-46
    # (final: prev: {
    #   mutter = prev.mutter.overrideAttrs (old: {
    #     src = pkgs.fetchFromGitLab  {
    #       domain = "gitlab.gnome.org";
    #       owner = "vanvugt";
    #       repo = "mutter";
    #       rev = "triple-buffering-v4-46";
    #       hash = "sha256-C2VfW3ThPEZ37YkX7ejlyumLnWa9oij333d5c4yfZxc=";
    #     };
    #   });
    # })
  ];
  #nixpkgs.overlays = lib.attrValues self.overlays;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
    nvidia-vaapi-driver
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
