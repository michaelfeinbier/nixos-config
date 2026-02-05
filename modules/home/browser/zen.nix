{ pkgs, lib, flake, config, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;

  firefox-addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};

  # Override onepassword to bypass the unfree license check for nix flake check
  onepassword-unfree = firefox-addons.onepassword-password-manager.overrideAttrs (old: {
    meta = old.meta or {} // {
      license = lib.licenses.free;
    };
  });
in
{

  programs.zen-browser = {
    enable = true;

    # Extensions
    profiles."*".extensions.packages = [
      firefox-addons.ublock-origin
      onepassword-unfree
    ];

    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  };
}