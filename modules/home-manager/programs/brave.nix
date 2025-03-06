{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
    ];
    commandLineArgs = [
      # copied this somewhere - not sure if it's necessary
      #"--disable-features=WebRtcAllowInputVolumeAdjustment"

      # Chrome is lagging with these settings
      #"--enable-features=UseOzonePlatform"
      #"--ozone-platform=wayland"
      "-enable-features=WaylandWindowDecorations"
      "--ozone-platform-hint=auto"
    ];
  };
}
