{
  imports = [
    ./chromium.nix
    ./zen.nix
  ];

  # Make zen the default browser
  xdg.mimeApps = {
    enable = true;

    defaultApplications."text/html" = "zen-twilight.desktop";
  };
}