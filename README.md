# NixOS Configuration

Welcome to my personal NixOS configuration. This project uses Nix Flakes and `flake-parts` to manage a modular system and Home Manager configuration.

## 🚀 Features

- **Window Manager:** [Hyprland](https://hyprland.org/) (wayland) with a customized, modular configuration.
- **Shell:** [Fish](https://fishshell.com/) with various utilities.
- **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/).
- **Editor:** [Neovim](https://neovim.io/) configured with Nix and Lua.
- **Browser:** [Zen Browser](https://zen-browser.app/) with custom CSS and profile management.
- **Styling:** Dynamic colors using [Pywal](https://github.com/dylanaraps/pywal).
- **Application Management:** Integrated [Flatpak](https://flatpak.org/) support.

## 📂 Project Structure

```text
/etc/nixos/
├── flake.nix             # Entry point for the flake
├── flake.lock            # Lockfile for reproducible builds
├── hardware-configuration.nix # Hardware-specific settings
├── hosts/                # Host-specific configurations
│   └── nixos.nix         # Main system configuration for 'nixos' host
├── home/                 # Home Manager configurations (User-level)
│   ├── apps/             # Application-specific configurations (Spotify, Zen, etc.)
│   ├── core/             # Core user settings (Styling, Scripts)
│   ├── desktop/          # Desktop environment (Hyprland, Wofi, GTK)
│   └── dev/              # Development tools (Neovim, VS Code, Fish, Kitty)
├── modules/              # System-level NixOS modules
│   ├── core/             # Essential system modules (Boot, Networking, Packages)
│   ├── hardware/         # Hardware-specific modules (GPU, Bluetooth, Sound)
│   ├── services/         # System services (Flatpak, KVM)
│   └── user-options.nix  # Custom global options (Username, Email, etc.)
├── parts/                # Flake-parts definitions
└── users/                # User account definitions
```

## 🛠️ Getting Started

### Prerequisites

- A running NixOS system.
- Experimental features `nix-command` and `flakes` enabled.

### Installation

1. Clone this repository into `/etc/nixos`:
   ```bash
   sudo git clone https://github.com/your-username/nixos-config.git /etc/nixos
   ```

2. Build and apply the configuration:
   ```bash
   sudo nixos-rebuild switch --flake .#nixos
   ```

## ⚙️ Customization

You can easily customize global user settings in `modules/user-options.nix`:

```nix
options.my.user = {
  name = "your-username";
  email = "your-email@example.com";
  fullName = "Your Full Name";
  # ... other options
};
```

---

*Made with ❤️ and Nix.*
