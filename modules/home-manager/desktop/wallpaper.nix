{
  lib,
  inputs,
  pkgs,
  ...
}:
{

  options.wallpaper = lib.mkOption {
    default = "${inputs.self}/files/wallpaper/catppuccin_triangle.png";
    type = lib.types.path;
    readOnly = true;
    description = "Path to the wallpaper";
  };

  config = {
    #wallpaper = "${pkgs.home-files}/.local/share/backgrounds/misc/comfy-home.png";

    home.file.".local/share/backgrounds" = {
      source = builtins.fetchGit {
        url = "https://github.com/zhichaoh/catppuccin-wallpapers.git";
        rev = "1023077979591cdeca76aae94e0359da1707a60e";
      };
    };
  };
}
