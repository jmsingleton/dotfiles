#!/usr/bin/env bash
# Deploy dotfiles using GNU stow
set -euo pipefail
cd "$(dirname "$0")"

packages_common=(fish ghostty btop lazygit tmux)
packages_linux=(hypr waybar dunst rofi wlogout)

case "$(uname)" in
    Darwin)
        packages=("${packages_common[@]}")
        ;;
    Linux)
        packages=("${packages_common[@]}" "${packages_linux[@]}")
        ;;
esac

for pkg in "${packages[@]}"; do
    stow -v --target="$HOME" "$pkg"
done

echo "Done! All dotfiles stowed."
