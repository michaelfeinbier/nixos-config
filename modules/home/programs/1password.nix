{ flake, pkgs, lib, ... }:
{
  # home.packages = with pkgs; [
  #   gh
  #   _1password-cli
  #   _1password-gui-beta
  # ];

  programs.zsh.envExtra = ''
    # For 1Password CLI. This requires `pkgs.gh` to be installed.
    source $HOME/.config/op/plugins.sh
  '';

  #programs._1password.enable = true;
  #programs._1password-gui.enable = true;

  imports = [ flake.inputs._1password-shell-plugins.hmModules.default ];

  programs._1password-shell-plugins = {
    enable = true;
    plugins = with pkgs; [ 
      gh
      awscli2
      hcloud
    ];
  };

  #make an own desktop item for 1password "silent"
  xdg.configFile."autostart/1password.desktop".text = ''
    [Desktop Entry]
    Name=1Password Tray Icon
    Exec=1password --silent %U
    Terminal=false
    Type=Application
    Icon=1password
    StartupWMClass=1Password
    Comment=Password manager and secure wallet
    MimeType=x-scheme-handler/onepassword4
  '';

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*".extraOptions = {
        identityAgent =
          if pkgs.stdenv.isDarwin
          then ''"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"''
          else ''"~/.1password/agent.sock"'';
      };
    };
  };

  # https://developer.1password.com/docs/ssh/git-commit-signing/
  #
  # For this to work on GitHub, you must have added the SSH pub key as a signing key, see
  # https://1password.community/discussion/comment/667515/#Comment_667515
  programs.git.includes = [{
    #condition = "gitdir:~/code/**"; # Personal repos only
    contents = {
      user.signingKey = flake.config.me.sshKey;
      gpg.format = "ssh";
      gpg.ssh.program =
        if pkgs.stdenv.isDarwin
        then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
        else "/opt/1Password/op-ssh-sign";
      commit.gpgsign = true;
    };
  }];
}
