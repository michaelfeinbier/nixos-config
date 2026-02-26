{
  flake, ...
}:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 13;
      theme = "noctalia";
      custom-shader = [
        "${flake.inputs.ghostty-shaders}/retro-terminal.glsl"
        "${flake.inputs.ghostty-shaders}/tft.glsl"
        "${flake.inputs.ghostty-shaders}/bloom.glsl"
      ];
    };
  };
}