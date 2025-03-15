{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    profiles.default = {
      userSettings = {
        "editor.fontLigatures" = true;
        "terminal.integrated.fontLigatures.enabled" = true;
        "git.confirmSync" = true;
        "git.autofetch" = true;
        "git.enableSmartCommit" = true;
        "editor.codeLensFontFamily" = "Jetbrains Mono Nerd Font";
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
      ];
    };
  };

  stylix.targets.vscode.enable = true;
  stylix.targets.vscode.profileNames = [ "default" ];
}
