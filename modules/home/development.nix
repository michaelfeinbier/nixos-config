{pkgs, ...}:
{
  home.packages = (with pkgs; [
    opentofu
    nodenv
    #corepack
    jetbrains.phpstorm
    ansible
    beekeeper-studio

    # PHP
    php84
    phpstan
  ]) ++ (with pkgs.php84Packages; [
    composer
    php-cs-fixer
  ]);

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.5.7"
  ];
}