# nixos-config

NixOS, nix-darwin, and Home Manager configuration built on the [nixos-unified](https://github.com/srid/nixos-unified) framework.

## Machines

| Host | Platform | Desktop | GPU | Description |
|------|----------|---------|-----|-------------|
| `saturn` | NixOS (x86_64) | Niri / Hyprland / GNOME | NVIDIA | Primary desktop |
| `nixos-gaming` | NixOS (x86_64) | Niri | NVIDIA | Gaming machine |
| `apollo` | macOS (aarch64-darwin) | &mdash; | &mdash; | MacBook |

## Quick Start

```bash
# Build and activate the system configuration
nix run --show-trace     # or: just run

# Update flake inputs
nix flake update         # or: just update

# Format nix files
nix fmt                  # or: just lint

# Check flake for errors
nix flake check          # or: just check

# Enter development shell (just, nixd, ags)
nix develop              # or: just dev

# View system profile history
just history
```

## Repository Structure

```
.
├── configurations/
│   ├── nixos/
│   │   ├── saturn/              # Primary desktop
│   │   ├── nixos-gaming/        # Gaming machine
│   │   └── test/                # Test VM
│   ├── darwin/
│   │   └── apollo/              # macOS config
│   └── home/
│       └── michael.nix          # Shared Home Manager entry point
├── modules/
│   ├── nixos/                   # NixOS system modules
│   │   ├── desktop/             # Desktop environments (Hyprland, GNOME, Niri, Stylix)
│   │   ├── gaming/              # Steam, Gamemode, VMware
│   │   ├── niri/                # Niri compositor (system-level)
│   │   ├── fonts.nix
│   │   ├── nix.nix
│   │   ├── packages.nix
│   │   ├── sound.nix
│   │   └── ...
│   ├── home/                    # Home Manager modules
│   │   ├── gui/
│   │   │   ├── hyprland/        # Hyprland WM config (keybinds, waybar, rofi)
│   │   │   ├── gnome/           # GNOME extensions & keybindings
│   │   │   ├── niri/            # Niri compositor (user-level)
│   │   │   ├── cosmic/          # COSMIC desktop
│   │   │   ├── plasma/          # KDE Plasma
│   │   │   └── wayland-common/  # Shared Wayland utilities
│   │   ├── browser/             # Zen Browser, Chromium
│   │   ├── neovim/              # Neovim via nixvim
│   │   ├── programs/            # Alacritty, tmux, Albert, VS Code, 1Password, etc.
│   │   ├── shell.nix
│   │   ├── git.nix
│   │   ├── packages.nix
│   │   └── ...
│   ├── darwin/                  # macOS-specific modules (Homebrew, system defaults)
│   └── flake/                   # Flake-level modules (devshell, formatter, config schema)
└── flake.nix
```

## How It Works

### nixos-unified Autowiring

The flake uses [nixos-unified](https://nixos-unified.org/autowiring.html) to automatically discover configurations and modules by scanning the directory tree. Adding a new module is as simple as creating a `.nix` file in the appropriate `modules/` subdirectory -- it gets auto-imported via `default.nix`.

### Global Config

User settings (username, email, SSH key, wallpaper) are defined in `modules/flake/config.nix` and available everywhere as `flake.config.me`. The schema lives in `modules/flake/config-module.nix`.

### Theming

Catppuccin Mocha with a teal accent, applied globally through the [catppuccin/nix](https://github.com/catppuccin/nix) module.

## Key Flake Inputs

| Input | Purpose |
|-------|---------|
| [nixvim](https://github.com/nix-community/nixvim) | Declarative Neovim configuration |
| [catppuccin/nix](https://github.com/catppuccin/nix) | Global Catppuccin theming |
| [zen-browser](https://github.com/0xc000022070/zen-browser-flake) | Zen Browser |
| [ags](https://github.com/aylur/ags) / [astal](https://github.com/aylur/astal) | Desktop shell widgets |
| [plasma-manager](https://github.com/nix-community/plasma-manager) | KDE Plasma declarative config |
| [noctalia-shell](https://github.com/noctalia-dev/noctalia-shell) | Noctalia shell |
| [nixos-hardware](https://github.com/NixOS/nixos-hardware) | Hardware-specific optimizations |
| [1Password shell-plugins](https://github.com/1Password/shell-plugins) | 1Password CLI integration |
| [nix-cachyos-kernel](https://github.com/xddxdd/nix-cachyos-kernel) | CachyOS kernel |
