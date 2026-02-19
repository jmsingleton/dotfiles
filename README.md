# Dotfiles

Arch Linux + Hyprland desktop with Rose Pine Moon theming throughout.

## Stack

| Layer | Tool |
|-------|------|
| OS | Arch Linux (BTRFS, systemd-boot) |
| Window Manager | Hyprland |
| Bar | Waybar |
| Terminal | Ghostty |
| Shell | Fish |
| Editor | Helix |
| Launcher | Rofi |
| Notifications | Dunst |
| Lock Screen | Hyprlock |
| Idle | Hypridle |
| Login | SDDM (sugar-dark) |
| Wallpaper | Hyprpaper + mpvpaper (day/night) |
| Logout | wlogout |

## CLI Tools

| Command | Tool | Replaces |
|---------|------|----------|
| `ls` | eza | ls |
| `cat` | bat | cat |
| `cd`/`z` | zoxide | cd |
| `du` | dust | du |
| `lg` | lazygit | git TUI |
| `hx` | helix | vim/nano |
| `btop` | btop | htop |
| `rg` | ripgrep | grep |
| `fd` | fd | find |
| `fzf` | fzf | — |
| `tldr` | tldr | man |

## Keybindings

### Apps
| Keys | Action |
|------|--------|
| `Super + Q` | Terminal (Ghostty) |
| `Super + B` | Browser (Firefox) |
| `Super + R` | App launcher (Rofi) |
| `Super + E` | File manager (Dolphin) |
| `Super + Escape` | Lock screen |
| `Super + G` | Clipboard history |

### Windows
| Keys | Action |
|------|--------|
| `Super + H/J/K/L` | Move focus (vim keys) |
| `Super + Shift + H/J/K/L` | Move window |
| `Super + Ctrl + H/J/K/L` | Resize window |
| `Super + C` | Close window |
| `Super + V` | Toggle floating |
| `Super + F` | Fullscreen |
| `Super + T` | Toggle split |
| `Super + 1-0` | Switch workspace |
| `Super + Shift + 1-0` | Move window to workspace |
| `Super + S` | Scratchpad |

### Screenshots & Recording
| Keys | Action |
|------|--------|
| `Print` | Select area to clipboard |
| `Shift + Print` | Full screen to clipboard |
| `Super + Print` | Select area to file |
| `Super + Shift + Print` | Full screen to file |
| `Super + Alt + Print` | Select area + annotate (swappy) |
| `Super + F9` | Start/stop screen recording |
| `Super + F10` | Stop recording |

### Fish Abbreviations
| Abbr | Expands to |
|------|------------|
| `gs` | `git status` |
| `gd` | `git diff` |
| `gl` | `git log --oneline -20` |
| `gp` | `git push` |
| `gc` | `git commit` |
| `ga` | `git add` |
| `gco` | `git checkout` |
| `gb` | `git branch` |
| `pacs` | `sudo pacman -S` |
| `pacr` | `sudo pacman -Rns` |
| `pacq` | `pacman -Qs` |
| `cc` | Start Claude Code in tmux |

## Backups

### Restic (file backup to NAS)
```bash
# Manual backup
~/dotfiles/backup/restic-backup.sh

# Check snapshots
restic -r /mnt/BigNAS/backups/restic --password-file ~/.config/restic/password snapshots

# Restore a file
restic -r /mnt/BigNAS/backups/restic --password-file ~/.config/restic/password restore latest --target /tmp/restore --include /path/to/file
```
Runs daily via systemd timer. Keeps 7 daily, 4 weekly, 6 monthly.

### Snapper (BTRFS snapshots)
```bash
# List snapshots
snapper -c root list
snapper -c home list

# Undo a bad change (between snapshot 1 and 2)
snapper -c root undochange 1..2

# Manual snapshot
snapper -c root create -d "before risky thing"
```
Automatic timeline snapshots: 5 hourly, 7 daily, 4 weekly. `snap-pac` takes before/after snapshots on every pacman transaction.

### Package list
```bash
# Save current package list
~/dotfiles/backup/save-packages.sh

# Restore on a fresh system
sudo pacman -S --needed - < ~/dotfiles/backup/packages-official.txt
yay -S --needed - < ~/dotfiles/backup/packages-aur.txt
```

## System Maintenance

Automated via systemd timers:
- **paccache** — cleans old package cache weekly (keeps 3 versions)
- **reflector** — updates pacman mirrors weekly (fastest US HTTPS mirrors)
- **snapper-timeline** — hourly BTRFS snapshots
- **snapper-cleanup** — prunes old snapshots per retention policy
- **restic-backup** — daily file backup to BigNAS

Check timers: `systemctl list-timers --all`

## Fresh Install

```bash
git clone https://github.com/jmsingleton/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
sudo pacman -S --needed - < backup/packages-official.txt
yay -S --needed - < backup/packages-aur.txt
```
