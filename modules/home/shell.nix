{ flake, pkgs, lib, ... }:
let
  inherit (flake) config inputs;
  inherit (inputs) self;
in
{

  programs = {
    bash.enable = false;

    # For macOS's default shell.
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      envExtra = ''
        # Custom ~/.zshenv goes here
      '';
      profileExtra = ''
        # Custom ~/.zprofile goes here
      '';
      loginExtra = ''
        # Custom ~/.zlogin goes here
      '';
      logoutExtra = ''
        # Custom ~/.zlogout goes here
      '';
      initExtra = ''
        fastfetch
      '';
    };

    # Type `z <pat>` to cd to some directory
    zoxide.enable = true;

    # Better shell prmot!
    starship = {
      enable = true;

      # load from rawfile
      settings = (builtins.fromTOML (builtins.readFile "${self}/raw-files/starship.toml"));

    };
  };

  # Install and configure fastfetch via home-manager module
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "none";
      };
      display = {
        separator = "->   ";
      };
      modules = [
        {
          type = "title";
          format = "{6}{7}{8}";
        }
        "break"
        {
          type = "custom";
          format = "┌───────────────────────────── System Information ─────────────────────────────┐";
        }
        "break"
        {
          key = "     OS           ";
          keyColor = "red";
          type = "os";
        }
        {
          key = "    󰌢 Machine      ";
          keyColor = "green";
          type = "host";
        }
        {
          key = "     Kernel       ";
          keyColor = "magenta";
          type = "kernel";
        }
        {
          key = "    󰏖 Packages     ";
          type = "packages";
        }
        {
          key = "    󰅐 Uptime       ";
          keyColor = "red";
          type = "uptime";
        }
        {
          key = "    󰍹 Resolution   ";
          keyColor = "yellow";
          type = "display";
          compactType = "original-with-refresh-rate";
        }
        {
          key = "     WM           ";
          keyColor = "blue";
          type = "wm";
        }
        {
          key = "     DE           ";
          keyColor = "green";
          type = "de";
        }
        {
          key = "     Shell        ";
          keyColor = "cyan";
          type = "shell";
        }
        {
          key = "     Terminal     ";
          keyColor = "red";
          type = "terminal";
        }
        {
          key = "    󰻠 CPU          ";
          keyColor = "yellow";
          type = "cpu";
        }
        {
          key = "    󰍛 GPU          ";
          keyColor = "blue";
          type = "gpu";
        }
        {
          key = "    󰑭 Memory       ";
          keyColor = "magenta";
          type = "memory";
        }
        {
          key = "    󰩟 Local IP     ";
          keyColor = "red";
          type = "localip";
        }
        {
          key = "    󰩠 Public IP    ";
          keyColor = "cyan";
          type = "publicip";
        }
        "break"
        {
          type = "custom";
          format = "└──────────────────────────────────────────────────────────────────────────────┘";
        }
        "break"
        {
          paddingLeft = 34;
          symbol = "circle";
          type = "colors";
        }
      ];
    };
  };
}
