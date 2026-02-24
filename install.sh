#!/usr/bin/env bash
# Deploy dotfiles using GNU stow
set -euo pipefail
cd "$(dirname "$0")"

packages_common=(fish ghostty btop lazygit tmux)
packages_macos=(aerospace)
packages_linux=(hypr waybar dunst rofi wlogout)

case "$(uname)" in
    Darwin)
        packages=("${packages_common[@]}" "${packages_macos[@]}")
        ;;
    Linux)
        packages=("${packages_common[@]}" "${packages_linux[@]}")
        ;;
esac

for pkg in "${packages[@]}"; do
    stow -v --target="$HOME" "$pkg"
done

# Karabiner rewrites its config atomically, breaking symlinks — copy instead
if [[ "$(uname)" == "Darwin" && -f karabiner/.config/karabiner/karabiner.json ]]; then
    mkdir -p "$HOME/.config/karabiner"
    cp -v karabiner/.config/karabiner/karabiner.json "$HOME/.config/karabiner/karabiner.json"
fi

echo "Done! All dotfiles stowed."
