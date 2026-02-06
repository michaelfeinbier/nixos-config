{pkgs, ...}:
{
  # Collection of game launcher
  environment.systemPackages = with pkgs; [
    bottles
    heroic
  ];
}