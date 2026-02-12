{ pkgs, lib, flake, ... }:
let
  inherit (flake) inputs;
  # Access the vscode extensions from the nix-vscode-extensions flake
  vscode-extensions = inputs.nix-vscode-extensions.extensions.${pkgs.system};
in

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

      # Extensions from nix-vscode-extensions flake
      extensions = (with vscode-extensions.vscode-marketplace; [
         bierner.markdown-mermaid
         jnoortheen.nix-ide
      #   bluebrown.yamlfmt
      #   github.copilot
      #   github.copilot-chat
      #   golang.go
         hashicorp.terraform
         k--kato.intellij-idea-keybindings
         vue.volar
      #   ms-azuretools.vscode-docker
         catppuccin.catppuccin-vsc
         tamasfe.even-better-toml
      ]) ++ (with pkgs.vscode-extensions; [
         # Unfree extensions that need pkgs.vscode-extensions
         bmewburn.vscode-intelephense-client
      ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
         # Manually fetched extensions
         {
           name = "kdl";
           publisher = "kdl-org";
           version = "2.1.3";
           sha256 = "sha256-Jssmb5owrgNWlmLFSKCgqMJKp3sPpOrlEUBwzZSSpbM=";
         }
      ];
    };
  };

  #stylix.targets.vscode.enable = false;
  #stylix.targets.vscode.profileNames = [ "default" ];
}
