# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NixOS and Home Manager configuration using the [nixos-unified](https://github.com/srid/nixos-unified) framework. It manages a Linux desktop ("saturn") with NVIDIA GPU and supports standalone home-manager on non-NixOS Linux and macOS.

## Common Commands

```bash
# Activate the configuration (NixOS rebuild)
just run
# or: nix run --show-trace

# Update flake inputs
just update
# or: nix flake update

# Format nix files
just lint
# or: nix fmt

# Check flake for errors
just check
# or: nix flake check

# Enter development shell
just dev
# or: nix develop

# View system profile history
just history
```

### Build Verification (Dry Run)

```bash
# NixOS configuration
nix eval .#nixosConfigurations.saturn.config.system.build.toplevel.drvPath

# Standalone home-manager configurations
nix eval '.#homeConfigurations."michael@linux".activationPackage.drvPath'
nix eval '.#homeConfigurations."michael@server".activationPackage.drvPath'
nix eval '.#homeConfigurations."michael@darwin".activationPackage.drvPath'
```

## Architecture

### Flake Structure

The flake uses **nixos-unified autowiring** which automatically discovers modules under `modules/` and configurations under `configurations/`.

- `flake.nix` - Main entry point, defines inputs
- `config.nix` - Global user configuration (`me.username`, `me.email`, etc.)
- `modules/flake/toplevel.nix` - Flake-parts setup and standalone homeConfigurations

### Module Organization

```
modules/
├── flake/           # Flake-level modules (config schema, devshell, etc.)
├── home/            # Home-manager modules (user environment)
│   ├── options.nix  # Feature flag definitions (myConfig.features.*)
│   ├── profiles/    # Presets: minimal, desktop, server
│   ├── core/        # Always-loaded: shell, git, direnv, packages
│   ├── features/    # Conditionally-loaded based on feature flags
│   │   ├── gui/         # GNOME, GTK, GUI packages
│   │   ├── development/ # VSCode, neovim, dev tools
│   │   ├── gaming/      # Discord, MangoHud
│   │   └── productivity/# 1Password, browser
│   └── platform/    # Platform-specific (linux.nix, darwin.nix)
└── nixos/           # NixOS system modules (sound, steam, gui, etc.)
```

### Feature Flags & Profiles

Home-manager uses a feature flag system (`myConfig.features.*`) controlled by profiles:

```nix
# Enable a profile preset
myConfig.profiles.desktop = true;  # Enables gui, development, productivity

# Override individual features
myConfig.features.gaming.enable = true;
```

Profiles automatically set feature defaults:
- **desktop**: gui, development, productivity enabled
- **server**: development only
- **minimal**: no features enabled

### Configuration Flow

1. `configurations/nixos/saturn/default.nix` - Host-specific NixOS config
2. Imports `self.nixosModules.*` from `modules/nixos/`
3. Sets up home-manager for user via `configurations/home/michael.nix`
4. Home config imports `self.homeModules.default` which loads all `modules/home/`

### Standalone Home-Manager

For non-NixOS systems, use the explicit `homeConfigurations`:
- `michael@linux` - Desktop Linux (x86_64)
- `michael@server` - Headless server (x86_64)
- `michael@darwin` - macOS (aarch64)

### Key Patterns

- **Global config access**: Use `flake.config.me` to access user info (username, email, sshKey)
- **Stylix integration**: Stylix provides theming; modules should use `lib.mkDefault` for settings that stylix may override
- **Conditional stylix**: For standalone configs without stylix, check `config.lib ? stylix` before accessing stylix colors
