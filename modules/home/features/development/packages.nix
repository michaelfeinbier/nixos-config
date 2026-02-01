{ pkgs, lib, config, ... }:

let
  cfg = config.me.features.development;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = (with pkgs; [
      opentofu
      nodenv
      corepack
      jetbrains.phpstorm
      ansible

      # PHP
      php82
      phpstan
    ]) ++ (with pkgs.php82Packages; [
      composer
      php-cs-fixer
    ]);
  };
}
