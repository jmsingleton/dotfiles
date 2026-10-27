set -l os (uname)

# --- Platform setup (needed by non-interactive shells too) ---
switch $os
    case Darwin
        # Static equivalent of `brew shellenv` (saves ~28ms per shell)
        set -gx HOMEBREW_PREFIX /opt/homebrew
        set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
        set -gx HOMEBREW_REPOSITORY /opt/homebrew
        fish_add_path --global --move --path /opt/homebrew/bin /opt/homebrew/sbin
        if test -n "$MANPATH"
            set -gx MANPATH (string replace --regex '^:*(.*?):*$' ':$1' -- "$MANPATH")
        end
        contains /opt/homebrew/share/info $INFOPATH; or set -gx INFOPATH /opt/homebrew/share/info $INFOPATH
        fish_add_path $HOME/.local/bin
    case Linux
        # Linux-specific PATH setup if needed
end

# bun
set -gx BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin

status is-interactive; or return

# --- Rose Pine Moon theme ---
set -g fish_color_normal e0def4
set -g fish_color_command 9ccfd8
set -g fish_color_keyword 3e8fb0
set -g fish_color_param ea9a97
set -g fish_color_quote f6c177
set -g fish_color_redirection c4a7e7
set -g fish_color_end c4a7e7
set -g fish_color_comment 6e6a86
set -g fish_color_error eb6f92
set -g fish_color_operator 908caa
set -g fish_color_escape ea9a97
set -g fish_color_autosuggestion 6e6a86
set -g fish_color_selection --background=393552
set -g fish_color_search_match --background=393552
set -g fish_color_valid_path
set -g fish_color_cwd 3e8fb0
set -g fish_color_cwd_root eb6f92
set -g fish_pager_color_progress 6e6a86
set -g fish_pager_color_prefix 9ccfd8
set -g fish_pager_color_completion e0def4
set -g fish_pager_color_description 6e6a86
set -g fish_pager_color_selected_background --background=393552

# Navigation
alias ..="cd .."
alias ls="eza --icons"
alias ll="eza -l --icons"
alias la="eza -la --icons"
alias lt="eza --tree --icons"

# Modern cat replacement
alias cat="bat --style=plain"

# Updates (platform-specific)
switch $os
    case Darwin
        alias update="brew update && brew upgrade"
        alias clip="pbcopy"
    case Linux
        alias update="sudo pacman -Syu"
        alias aurupdate="yay -Syu"
        alias flatupdate="flatpak update"
        alias hx="helix" # Arch names the binary helix; Homebrew ships hx
        alias hwinfo="neofetch"
        alias logout="hyprctl dispatch exit"
        abbr -a pacs sudo pacman -S
        abbr -a pacr sudo pacman -Rns
        abbr -a pacq pacman -Qs
end

# System
alias ports="sudo lsof -i -P -n | grep LISTEN"

# Utility
alias c="clear"
alias myip="curl ifconfig.me"

function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

# Applications
alias lg="lazygit"
alias du="dust"

# Git abbreviations (expand in-place so history shows real commands)
abbr -a gs git status
abbr -a gd git diff
abbr -a gl git log --oneline -20
abbr -a gp git push
abbr -a gc git commit
abbr -a ga git add
abbr -a gco git checkout
abbr -a gb git branch

# Smart cd: z <query>, zi for interactive picker
zoxide init fish | source
# direnv: hooked automatically by Homebrew's vendor_conf.d/direnv.fish

# Claude Code in tmux (named cct so it doesn't shadow the C compiler `cc`)
# Own window named after the dir; drops back to a shell when claude exits so the
# window survives. Args pass through, e.g. `cct --continue` to resume.
function cct --description 'Start Claude Code in a tmux window'
    set -l name cc-(string replace -a . _ (basename $PWD))
    if set -q TMUX
        tmux new-window -n $name -c $PWD "claude $argv; exec fish"
    else
        tmux new-session -A -s $name -c $PWD "claude $argv; exec fish"
    end
end
