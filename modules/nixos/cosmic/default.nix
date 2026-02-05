{ pkgs, ... }:
{
  # Enable COSMIC Desktop Environment
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  #services.system76-scheduler.enable = true;

  # Add COSMIC-specific packages
  environment.systemPackages = with pkgs; [
    # Add any additional COSMIC-related packages here
  ];

  # Exclude these COSMIC apps
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-term
    cosmic-player
    cosmic-store
  ];
}
