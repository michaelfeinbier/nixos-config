{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";

        "editor.fontLigatures" = true;
        "editor.acceptSuggestionOnEnter" = "off";
        "editor.codeLensFontFamily" = "Jetbrains Mono Nerd Font";
        "editor.inlayHints.fontFamily" = "Jetbrains Mono Nerd Font";
        "editor.semanticHighlighting.enabled" = true;

        # prevent VSCode from modifying the terminal colors
        "terminal.integrated.minimumContrastRatio" = 1;
        "terminal.integrated.fontLigatures.enabled" = true;
        "git.confirmSync" = false;
        "git.autofetch" = true;
        "git.enableSmartCommit" = true;
        "window.titleBarStyle" = "custom";
      };

      extensions = with pkgs.vscode-marketplace; [
        bierner.markdown-mermaid
        jnoortheen.nix-ide
        bluebrown.yamlfmt
        bmewburn.vscode-intelephense-client
        github.copilot
        github.copilot-chat
        golang.go
        hashicorp.terraform
        k--kato.intellij-idea-keybindings
        vue.volar
        ms-azuretools.vscode-docker
        catppuccin.catppuccin-vsc
      ];
    };
  };

  stylix.targets.vscode.enable = false;
  stylix.targets.vscode.profileNames = [ "default" ];
}
