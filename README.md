# nixos

Flake-based NixOS + Home Manager setup. One user, one host, fully declarative.

## architecture

```
flake.nix                # inputs: nixpkgs-unstable, home-manager, sops-nix, zen, spicetify, llama-cpp, audio.cpp, 9router
hosts/nixos.nix          # host entry -> modules + users
modules/                 # system-level
  user-options.nix       # `my.user.{name,email,fullName,zenProfile}` — single source of truth
  core/                  # boot, nix, networking, fish, sops, zram, pam, location, nix-ld
  hardware/              # gpu, sound, tlp, bluetooth, usb
  services/              # hyprland, searxng, 3proxy
home/                    # home-manager (username/homedir forced from `osConfig.my.user`)
  core/                  # style/palette, fonts, scripts/nixify, bluetui, impala
  desktop/               # hyprland (lua config), wofi, gtk, xdg
  dev/                   # per-lang `code/{cpp,go,rust,python,lua,nix,...}` + nvim, kitty, fish, docker, direnv
  apps/                  # zen, spotify, llama-cpp, audio-cpp, steam, discord, tor, wine, yazi, zathura
users/users.nix          # user def, fish shell, wheel/video/input
secrets.yaml             # sops-nix + age encrypted API keys
```

Smart bit: `my.user` options flow from NixOS -> Home Manager via `osConfig`, so username/email/profile rename in one place. Zen `user.js` and paths are templated with `replaceStrings` the same way.

## cool features

- **Fast by default:** zen kernel, `BBR + fq`, zstd initrd, tmpfs `/tmp`, volatile 200M journal, `dbus-broker`, `oomd`, docs/installer-tools disabled, weekly GC, `zramSwap` 50% zstd.
- **Modern networking:** `iwd` + `systemd-networkd` + `systemd-resolved` (1.1.1.1/8.8.8.8, DNSSEC allow-downgrade), WiFi powersave off via udev, roaming thresholds, `irqbalance`.
- **Laptop tuned:** TLP performance-on-AC / powersave-on-BAT (BAT capped at 20%), PCIe/runtime PM, battery charge limits 40-80%, lid-to-suspend, AMD P-state + `amdgpu` VA-API.
- **Secrets done right:** `sops-nix` with age (`nvidia/mistral/tokenrouter/inferx` keys, `0440`, user-owned).
- **Self-hosted search:** local SearXNG on `127.0.0.1:8888` with local Redis, image proxy, POST-only, no limiter + 3proxy SOCKS on 1080.
- **Hyprland in Lua:** `configType = "lua"` with split `settings/windows/monitors/binds/groups/hyprpaper/hyprshot`. Central `style/palette` theme injects opacity/colors into Zen via generated `nix-colors.css`.
- **Dev env:** per-language modules auto-pull LSP/linters (pyright/ruff, nixd/statix, lua-ls, gopls, clang-tools), Neovim Lua config symlinked verbatim, plus direnv/docker/kitty/fish/gh.
- **App flakes:** Zen Browser + Nebula chrome theme, Spicetify (adblock/hidePodcasts), `llama-cpp` + `audio.cpp` with local models, PrismLauncher-Cracked, Steam, Tor, Wine.

## rebuild

```bash
sudo nixos-rebuild switch --flake .#nixos
sops secrets.yaml  # edit keys
```

