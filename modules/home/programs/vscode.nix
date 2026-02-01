{ pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    profiles.default = {
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";

        "editor.fontSize" = 13;
        "editor.fontFamily" = "'JetbrainsMono Nerd Font', 'Droid Sans Mono', monospace";
        "editor.fontLigatures" = true;
        "editor.acceptSuggestionOnEnter" = "off";
        "editor.codeLensFontFamily" = "JetbrainsMono Nerd Font";
        "editor.inlayHints.fontFamily" = "JetbrainsMono Nerd Font";
        "editor.semanticHighlighting.enabled" = true;
        "editor.minimap.enabled" = false;

        # prevent VSCode from modifying the terminal colors
        "terminal.integrated.minimumContrastRatio" = 1;
        "terminal.integrated.fontLigatures.enabled" = true;
        "git.confirmSync" = false;
        "git.autofetch" = true;
        "git.enableSmartCommit" = true;
        "window.titleBarStyle" = "custom";
      };

      # @FIXME - does not work with home-manager only
      # extensions = with pkgs.vscode-marketplace; [
      #   bierner.markdown-mermaid
      #   jnoortheen.nix-ide
      #   bluebrown.yamlfmt
      #   bmewburn.vscode-intelephense-client
      #   github.copilot
      #   github.copilot-chat
      #   golang.go
      #   hashicorp.terraform
      #   k--kato.intellij-idea-keybindings
      #   vue.volar
      #   ms-azuretools.vscode-docker
      #   catppuccin.catppuccin-vsc
      #   tamasfe.even-better-toml
      # ];
    };
  };

  #stylix.targets.vscode.enable = false;
  #stylix.targets.vscode.profileNames = [ "default" ];
}
