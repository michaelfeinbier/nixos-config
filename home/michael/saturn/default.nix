{ homeModules, ... }:
{
  imports = [
    "${homeModules}/programs/brave.nix"
    "${homeModules}/programs/vscode.nix"
    #"${homeModules}/configs/waybar.nix"
    #"${homeModules}/configs/stylix.nix"
  ];
}
