{ lib, config, ... }:
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
            default = /home/michael/.local/share/wallpaper/aesthetic-wallpapers/images/colorful-planets.jpg;
          };
        };
      };
    };
  };
}
