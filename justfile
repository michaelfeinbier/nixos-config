# Like GNU `make`, but `just` rustier.
# https://just.systems/
# run `just` from this directory to see available commands

# Tag prefix for NixOS generation tags (e.g. nixos-gen42)
tag_prefix := "nixos"

# Default command when 'just' is run without arguments
default:
  @just --list

# Update nix flake
[group('Main')]
update:
  nix flake update

# Lint nix files
[group('dev')]
lint:
  nix fmt

# Check nix flake
[group('dev')]
check:
  nix flake check

# Manually enter dev shell
[group('dev')]
dev:
  nix develop

# Activate the configuration, then commit and tag with the new generation number
[group('Main')]
run:
  #!/usr/bin/env bash
  set -euo pipefail
  nix run --show-trace
  gen=$(readlink /nix/var/nix/profiles/system | sed 's/system-\([0-9]*\)-link/\1/')
  tag="{{ tag_prefix }}-gen${gen}"
  git add -A
  if git diff --cached --quiet; then
    echo "No changes to commit for generation ${gen}."
  else
    git commit -m "Apply NixOS generation ${gen}"
  fi
  if git tag -l "${tag}" | grep -q .; then
    echo "Tag ${tag} already exists, skipping."
  else
    git tag "${tag}"
    echo "Tagged as ${tag}"
  fi

# Run astal
[group('Astal')]
ags:
  ags run --gtk4

# Build astal
[group('Astal')]
bundle:
  ags bundle astal/app.ts dnkwt-shell

[group('History')]
history:
  nix profile history --profile /nix/var/nix/profiles/system