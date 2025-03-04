{
  lib,
  self,
  inputs,
  ...
}:
{

  options.wallpaper = lib.mkOption {
    default = "${inputs.self}/files/wallpaper/catppuccin_triangle.png";
    type = lib.types.path;
    readOnly = true;
    description = "Path to the wallpaper";
  };

}
