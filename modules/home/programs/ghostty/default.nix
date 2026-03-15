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
      shell-integration-features = "ssh-terminfo";
      custom-shader = [
        # "${flake.inputs.ghostty-shaders}/retro-terminal.glsl"
         "${flake.inputs.ghostty-shaders}/tft.glsl"
         "${flake.inputs.ghostty-shaders}/bettercrt.glsl"
        # "${flake.inputs.ghostty-shaders}/bloom.glsl"
        #"${flake.inputs.ghostty-shaders}/glitchy.glsl"
      ];
    };
  };

  # needed to suck les in ssh connections
  programs.ssh.matchBlocks."*".setEnv = {
    TERM = "xterm-256color";
  };
  #catppuccin.ghostty.enable = true;
}