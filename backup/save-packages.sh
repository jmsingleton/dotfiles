#!/usr/bin/env bash
# Save installed package lists to dotfiles for easy reinstall
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"

# Official repo packages (explicitly installed)
pacman -Qqe | grep -v "$(pacman -Qqm)" > "$DIR/packages-official.txt"

# AUR packages
pacman -Qqm > "$DIR/packages-aur.txt"

echo "Saved $(wc -l < "$DIR/packages-official.txt") official + $(wc -l < "$DIR/packages-aur.txt") AUR packages"

# To restore on a new system:
# sudo pacman -S --needed - < packages-official.txt
# yay -S --needed - < packages-aur.txt
