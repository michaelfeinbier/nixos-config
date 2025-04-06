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
      shellAliases = {
        tofu = "op run --env-file='./auth.env' -- tofu";
      };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
        ];
      };
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
          keyColor = "green";
          type = "os";
        }
        {
          key = "    󰌢 Machine      ";
          keyColor = "cyan";
          type = "host";
        }
        {
          key = "     Kernel       ";
          keyColor = "blue";
          type = "kernel";
        }
        {
          key = "    󰏖 Packages     ";
          keyColor = "green";
          type = "packages";
        }
        {
          key = "    󰅐 Uptime       ";
          keyColor = "cyan";
          type = "uptime";
        }
        {
          key = "    󰍹 Resolution   ";
          keyColor = "blue";
          type = "display";
          compactType = "original-with-refresh-rate";
        }
        {
          key = "     WM           ";
          keyColor = "green";
          type = "wm";
        }
        {
          key = "     DE           ";
          keyColor = "cyan";
          type = "de";
        }
        {
          key = "     Shell        ";
          keyColor = "blue";
          type = "shell";
        }
        {
          key = "     Terminal     ";
          keyColor = "green";
          type = "terminal";
        }
        {
          key = "    󰻠 CPU          ";
          keyColor = "cyan";
          type = "cpu";
        }
        {
          key = "    󰍛 GPU          ";
          keyColor = "blue";
          type = "gpu";
        }
        {
          key = "    󰑭 Memory       ";
          keyColor = "green";
          type = "memory";
        }
        {
          key = "    󰩟 Local IP     ";
          keyColor = "cyan";
          type = "localip";
        }
        {
          key = "    󰩠 Public IP    ";
          keyColor = "blue";
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
          block = {
            width = 10;
          };
        }
      ];
    };
  };
}
