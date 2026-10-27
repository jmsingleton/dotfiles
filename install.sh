#!/usr/bin/env bash
# Deploy dotfiles using GNU stow
set -euo pipefail
cd "$(dirname "$0")"

packages_common=(fish ghostty btop lazygit tmux)
packages_macos=()
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

# Ghostty on macOS also loads Application Support/config on top of ~/.config/ghostty —
# remove it so the stowed config is the single source of truth
if [[ "$(uname)" == "Darwin" ]]; then
    ghostty_appsupport="$HOME/Library/Application Support/com.mitchellh.ghostty/config"
    [[ -f "$ghostty_appsupport" ]] && mv -v "$ghostty_appsupport" "$ghostty_appsupport.bak"
    echo "command = /opt/homebrew/bin/tmux new-session -A -s main" > ghostty/.config/ghostty/local
fi

echo "Done! All dotfiles stowed."
