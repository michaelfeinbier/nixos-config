{pkgs, ...}:
{
  home.packages = (with pkgs; [
    opentofu
    nodenv
    #corepack
    jetbrains.phpstorm
    ansible

    # PHP
    php84
    phpstan
  ]) ++ (with pkgs.php84Packages; [
    composer
    php-cs-fixer
  ]);
}