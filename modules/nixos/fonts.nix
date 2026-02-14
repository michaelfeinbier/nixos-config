{ pkgs, ... }:
let
  apple-fonts = pkgs.stdenvNoCC.mkDerivation {
    pname = "apple-fonts-collection";
    version = "unstable-2024-11-28";
    src = pkgs.fetchFromGitHub {
      owner = "0xsharkboy";
      repo = "Apple-Fonts-Collection";
      rev = "a792c102edc93ca575d2c73bc8b727b2e0928b31";
      hash = "sha256-8EZ7fYy6CONkyj3dHOsaVSF0oMRH+SRZclwdrMSA0h8=";
    };
    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/fonts/truetype
      mkdir -p $out/share/fonts/opentype
      find . -name '*.ttf' -exec cp {} $out/share/fonts/truetype/ \;
      find . -name '*.otf' -exec cp {} $out/share/fonts/opentype/ \;
      runHook postInstall
    '';
  };
in
{
  # Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-mono
    nerd-fonts.meslo-lg
    roboto
    dejavu_fonts
    texlivePackages.clearsans
    meslo-lg
    apple-fonts
  ];
}
