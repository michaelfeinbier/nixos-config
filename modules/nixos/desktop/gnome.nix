{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    cheese # webcam tool
    gnome-music
    gedit # text editor
    #]) ++ (with pkgs.gnome; [
    epiphany # web browser
    geary # email reader
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    yelp # Help view
    orca # screen reader
    gnome-contacts
    gnome-initial-setup
  ]);

  environment.systemPackages = with pkgs; [
    pkgs.gnome-tweaks
  ];
}
