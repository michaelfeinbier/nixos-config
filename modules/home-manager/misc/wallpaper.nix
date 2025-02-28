{
  lib,
  self,
  inputs,
  ...
}:
{

  options.wallpaper = lib.mkOption {
    default = "${inputs.self}/files/wallpaper/path-to-heaven.jpg";
    type = lib.types.path;
    readOnly = true;
    description = "Path to the wallpaper";
  };

}
