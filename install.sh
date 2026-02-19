#!/usr/bin/env bash
# Symlink dotfiles into place
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

link() {
    local src="$1" dst="$2"
    mkdir -p "$(dirname "$dst")"
    if [ -L "$dst" ]; then
        rm "$dst"
    elif [ -e "$dst" ]; then
        echo "Backing up $dst -> ${dst}.bak"
        mv "$dst" "${dst}.bak"
    fi
    ln -s "$src" "$dst"
    echo "Linked $dst -> $src"
}

# Hyprland
link "$DOTFILES/hypr" "$HOME/.config/hypr"

# Fish
link "$DOTFILES/fish/config.fish" "$HOME/.config/fish/config.fish"

# Waybar
link "$DOTFILES/waybar" "$HOME/.config/waybar"

# Dunst
link "$DOTFILES/dunst" "$HOME/.config/dunst"

# Rofi
link "$DOTFILES/rofi/config.rasi" "$HOME/.config/rofi/config.rasi"

# Ghostty
link "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

# btop
link "$DOTFILES/btop/btop.conf" "$HOME/.config/btop/btop.conf"
link "$DOTFILES/btop/themes" "$HOME/.config/btop/themes"

# lazygit
link "$DOTFILES/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

# tmux
link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo "Done! All dotfiles linked."
