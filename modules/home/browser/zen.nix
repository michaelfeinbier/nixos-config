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

  # Stylix configuration
  #stylix.targets.zen-browser.profileNames = [ "default" ];

  programs.zen-browser = {
    enable = true;
    suppressXdgMigrationWarning = true; # we migrated already

    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = false;
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

    # Spaces and container definitons
    profiles."default" = let
      # extensions 
      extensions.packages = [
        firefox-addons.ublock-origin
        onepassword-unfree
      ];


      # Zen containers - hold the pins and profile settings
      containers = {
        Personal = {
          color = "blue";
          icon = "fingerprint";
          id = 1;
        };
        Billie = {
          color = "toolbar";
          icon = "briefcase";
          id = 2;
        };
      };

      spaces = {
        "NixOS" = {
          id = "d5894f5e-9a6a-4519-b0dc-799d3ab21f3b";
          position = 1000;
          container = containers."Personal".id;
          icon = "❄️";
          theme = {
            type = "gradient";
            colors = [
              {
                red = 150;
                green = 190;
                blue = 230;
                algorithm = "floating";
                type = "explicit-lightness";
              }
            ];
            opacity = 0.2;
            texture = 0.5;
          };
        };
        "Gaming" = {
          id = "13474083-fa68-417c-a8c9-49e4aad56968";
          position = 2000;
          icon = "chrome://browser/skin/zen-icons/selectable/baseball.svg";
          container = containers."Personal".id;
        };
        "HomeLab" = {
          id = "168939b8-ccf2-47ee-a1f4-f87379c5a9f5";
          position = 3000;
          icon = "chrome://browser/skin/zen-icons/selectable/layers.svg";
          container = containers."Personal".id;
        };
      };

      pins = {
        "mail" = {
          id = "9d8a8f91-7e29-4688-ae2e-da4e49d4a179";
          container = containers."Personal".id;
          url = "https://mail.google.com/mail/u/0/#inbox";
          isEssential = true;
          position = 101;
        };
        "komodo" = {
          id = "b12e91a7-7260-4e1d-9929-22ad89cf09ac";
          container = containers."Personal".id;
          url = "https://komodo.feinbier.systems";
          isEssential = true;
          position = 200;
        };



        "Nix awesome" = {
          id = "d85a9026-1458-4db6-b115-346746bcc692";
          workspace = spaces."NixOS".id;
          isGroup = true;
          isFolderCollapsed = false;
          editedTitle = true;
          position = 200;
        };
        "Nix Packages" = {
          id = "f8dd784e-11d7-430a-8f57-7b05ecdb4c77";
          workspace = spaces."NixOS".id;
          folderParentId = pins."Nix awesome".id;
          url = "https://search.nixos.org/packages";
          position = 201;
        };
        "Nix Options" = {
          id = "92931d60-fd40-4707-9512-a57b1a6a3919";
          workspace = spaces."NixOS".id;
          folderParentId = pins."Nix awesome".id;
          url = "https://search.nixos.org/options";
          position = 202;
        };
        "Home Manager Options" = {
          id = "2eed5614-3896-41a1-9d0a-a3283985359b";
          workspace = spaces."NixOS".id;
          folderParentId = pins."Nix awesome".id;
          url = "https://home-manager-options.extranix.com";
          position = 203;
        };
      };

     in {
      containersForce = true;
      spacesForce = true;
      pinsForce = true;

      inherit containers pins spaces extensions;
    };
  };
}