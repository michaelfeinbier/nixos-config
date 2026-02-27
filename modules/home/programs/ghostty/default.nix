{
  flake, ...
}:
{
  programs.ghostty = {
    enable = true;
    settings = {
      # font-size = 13;
      # theme = "noctalia";
      background-opacity = 0.9;
      custom-shader = [
        # "${flake.inputs.ghostty-shaders}/retro-terminal.glsl"
         "${flake.inputs.ghostty-shaders}/tft.glsl"
         "${flake.inputs.ghostty-shaders}/bettercrt.glsl"
        # "${flake.inputs.ghostty-shaders}/bloom.glsl"
        #"${flake.inputs.ghostty-shaders}/glitchy.glsl"
      ];
    };
  };

  catppuccin.ghostty.enable = true;
}