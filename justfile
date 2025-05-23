# Like GNU `make`, but `just` rustier.
# https://just.systems/
# run `just` from this directory to see available commands

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

# Activate the configuration
[group('Main')]
run:
  nix run --show-trace

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