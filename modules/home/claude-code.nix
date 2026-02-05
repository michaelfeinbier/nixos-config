{pkgs, ...}:
{
  home.packages = (with pkgs; [
    claude-code
    uv # package manager for nixos-mcp
  ]);
}