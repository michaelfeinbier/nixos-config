{ ... }:
{

  # Enable catppuccin theming for alacritty.
  #catppuccin.alacritty.enable = true;

  programs.alacritty = {
    enable = true;

    settings = {
      terminal = {
        # shell.program = "zsh";
        # shell.args = [
        #   "-l"
        #   "-c"
        #   "tmux attach || tmux "
        # ];
      };

      env = {
        TERM = "xterm-256color";
      };

      # Handled by stlix
      #   font = {
      #     size = 11;

      #     normal = {
      #       family = "FiraMono Nerd Font";
      #       style = "Regular";
      #     };
      #     bold = {
      #       family = "FiraMono Nerd Font";
      #       style = "Bold";
      #     };
      #     italic = {
      #       family = "FiraMono Nerd Font";
      #       style = "Italic";
      #     };
      #     bold_italic = {
      #       family = "FiraMono Nerd Font";
      #       style = "Italic";
      #     };
      #   };
    };
  };
}
