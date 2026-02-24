#!/usr/bin/env bash
# Deploy dotfiles using GNU stow
set -euo pipefail
cd "$(dirname "$0")"

packages=(hypr fish waybar dunst rofi ghostty btop lazygit tmux wlogout)

for pkg in "${packages[@]}"; do
    stow -v --target="$HOME" "$pkg"
done

echo "Done! All dotfiles stowed."
