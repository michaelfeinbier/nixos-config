{pkgs, ...}:
{
  home.packages = (with pkgs; [
    opentofu
    nodenv
    corepack
    jetbrains.phpstorm
    ansible
    claude-code
    #corepack_18

    # PHP
    php82
    phpstan
  ]) ++ (with pkgs.php82Packages; [
    composer
    php-cs-fixer
  ]);
}