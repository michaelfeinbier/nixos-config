{ pkgs, lib, config, ... }:

let
  cfg = config.me.features.development;
  guiEnabled = config.me.features.gui.enable;
in
{
  # VSCode only makes sense with GUI enabled
  config = lib.mkIf (cfg.enable && guiEnabled) {
    programs.vscode = {
      enable = true;

      profiles.default = {
        userSettings = {
          "workbench.colorTheme" = lib.mkDefault "Catppuccin Mocha";

          "editor.fontSize" = lib.mkDefault 11;
          "editor.fontFamily" = lib.mkDefault "'JetbrainsMono Nerd Font', 'Droid Sans Mono', monospace";
          "editor.fontLigatures" = lib.mkDefault true;
          "editor.acceptSuggestionOnEnter" = lib.mkDefault "off";
          "editor.codeLensFontFamily" = lib.mkDefault "Jetbrains Mono Nerd Font";
          "editor.inlayHints.fontFamily" = lib.mkDefault "Jetbrains Mono Nerd Font";
          "editor.semanticHighlighting.enabled" = lib.mkDefault true;
          "editor.minimap.enabled" = lib.mkDefault false;

          # prevent VSCode from modifying the terminal colors
          "terminal.integrated.minimumContrastRatio" = lib.mkDefault 1;
          "terminal.integrated.fontLigatures.enabled" = lib.mkDefault true;
          "git.confirmSync" = lib.mkDefault false;
          "git.autofetch" = lib.mkDefault true;
          "git.enableSmartCommit" = lib.mkDefault true;
          "window.titleBarStyle" = lib.mkDefault "custom";
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
          tamasfe.even-better-toml
        ];
      };
    };
  };
}
