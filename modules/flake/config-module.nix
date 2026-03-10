{ lib, config, inputs, ... }:
{
  options = {
    me = lib.mkOption {
      default = { };
      type = lib.types.submodule {
        options = {
          username = lib.mkOption {
            type = lib.types.str;
            description = "Your username as shown by `id -un`";
          };
          fullname = lib.mkOption {
            type = lib.types.str;
            description = "Your full name for use in Git config";
          };
          email = lib.mkOption {
            type = lib.types.str;
            description = "Your email for use in Git config";
          };
          sshKey = lib.mkOption {
            type = lib.types.str;
            description = ''
              SSH public key
            '';
          };
          wallpaper = lib.mkOption {
            type = lib.types.path;
            description = "Path to your wallpaper";
            default = "${inputs.aesthetic-wallpapers}/images/colorful-planets.jpg";
          };
          color = lib.mkOption {
            type = lib.types.str;
            description = "The base16 color name scheme from https://tinted-theming.github.io/tinted-gallery/";
            default = "catppuccin-mocha";
          };
        };
      };
    };
  };
}
