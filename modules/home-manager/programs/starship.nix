{ ... }:
{
  # Starship configuration
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;

      directory = {
        truncation_length = 3;
        style = "bold lavender";
      };

      php = {
        symbol = " ";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";

      };
    };
  };

  # Enable catppuccin theming for starship.
  #catppuccin.starship.enable = true;
}
