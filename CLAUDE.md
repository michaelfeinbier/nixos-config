# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a NixOS and Home Manager configuration using the [nixos-unified](https://github.com/srid/nixos-unified) framework. It manages system and user configuration for NixOS machines with support for multiple desktop environments (Hyprland, GNOME).

## Commands

```bash
# Activate the configuration (build and switch)
nix run --show-trace
# or
just run

# Update flake inputs
nix flake update
# or
just update

# Format nix files
nix fmt
# or
just lint

# Check flake for errors
nix flake check
# or
just check

# Enter development shell (includes just, nixd, ags)
nix develop
# or
just dev

# View system profile history
just history
```

## Architecture

### nixos-unified Framework

This repo uses nixos-unified's autowiring system. The flake outputs are generated automatically by scanning:
- `configurations/nixos/<hostname>/` - NixOS system configurations
- `configurations/home/<username>.nix` - Home Manager configurations
- `modules/flake/` - Flake-level modules (devshell, formatter, config schema)
- `modules/nixos/` - NixOS modules (auto-imported via `default.nix`)
- `modules/home/` - Home Manager modules (auto-imported via `default.nix`)

### Global Configuration

User settings are defined in `config.nix` and made available throughout via `flake.config.me`. The schema is defined in `modules/flake/config-module.nix`.

### Module Auto-Import Pattern

Both `modules/nixos/default.nix` and `modules/home/default.nix` automatically import all sibling `.nix` files. To add a new module, just create a new file in the appropriate directory.

### Key Directories

- `modules/home/gui/hyprland/` - Hyprland window manager configuration
- `modules/home/gui/gnome/` - GNOME desktop configuration
- `modules/nixos/gui/` - System-level GUI setup (fonts, stylix theming)
- `modules/home/neovim/` - Neovim configuration via nixvim

### Machine Configuration

The `saturn` machine configuration in `configurations/nixos/saturn/` demonstrates the pattern:
- `default.nix` - Top-level imports and hardware-specific settings
- `configuration.nix` - Base system settings (bootloader, networking, users)
- `hardware-configuration.nix` - Auto-generated hardware config
