{pkgs, ...}:
{
  home.packages = (with pkgs; [
    opentofu
    nodenv
    corepack
    jetbrains.phpstorm
    ansible
    #corepack_18

    # PHP
    php82
  ]) ++ (with pkgs.php82Packages; [
    composer
    php-cs-fixer
    phpstan
  ]);
}