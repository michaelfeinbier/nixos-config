# macOS system preferences - developer-friendly defaults
{ ... }:

{
  system.defaults = {
    # Dock settings
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 0.2;
      show-recents = false;
      mru-spaces = false; # Don't rearrange spaces based on most recent use
      minimize-to-application = true;
      orientation = "bottom";
      tilesize = 48;
    };

    # Finder settings
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true; # Show hidden files
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "Nlsv"; # List view
      FXDefaultSearchScope = "SCcf"; # Search current folder by default
      FXEnableExtensionChangeWarning = false;
      _FXShowPosixPathInTitle = true;
    };

    # Global macOS settings
    NSGlobalDomain = {
      # Keyboard settings
      ApplePressAndHoldEnabled = false; # Enable key repeat
      InitialKeyRepeat = 15; # Faster initial key repeat
      KeyRepeat = 2; # Faster key repeat rate
      AppleKeyboardUIMode = 3; # Full keyboard navigation

      # Appearance
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;

      # Input settings
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      # Window behavior
      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;

      # Scroll behavior
      AppleShowScrollBars = "WhenScrolling";

      # 24-hour time
      AppleICUForce24HourTime = true;
    };

    # Trackpad settings
    trackpad = {
      Clicking = true; # Tap to click
      TrackpadRightClick = true; # Two-finger right click
      TrackpadThreeFingerDrag = true; # Three-finger drag
    };

    # Login window
    loginwindow = {
      GuestEnabled = false;
      DisableConsoleAccess = true;
    };

    # Screenshot settings
    screencapture = {
      location = "~/Pictures/Screenshots";
      type = "png";
      disable-shadow = true;
    };

    # Spaces/Mission Control
    spaces = {
      spans-displays = false;
    };

    # Menu bar clock
    menuExtraClock = {
      Show24Hour = true;
      ShowSeconds = false;
    };

    # Custom user preferences
    CustomUserPreferences = {
      # Disable hot corners
      "com.apple.dock" = {
        wvous-tl-corner = 1; # Disabled
        wvous-tr-corner = 1; # Disabled
        wvous-bl-corner = 1; # Disabled
        wvous-br-corner = 1; # Disabled
      };
    };
  };

  # Keyboard remapping - Caps Lock to Escape
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
}
