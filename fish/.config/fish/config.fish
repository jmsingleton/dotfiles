# --- Rose Pine Moon theme ---
set -U fish_color_normal e0def4
set -U fish_color_command 9ccfd8
set -U fish_color_keyword 3e8fb0
set -U fish_color_param ea9a97
set -U fish_color_quote f6c177
set -U fish_color_redirection c4a7e7
set -U fish_color_end c4a7e7
set -U fish_color_comment 6e6a86
set -U fish_color_error eb6f92
set -U fish_color_operator 908caa
set -U fish_color_escape ea9a97
set -U fish_color_autosuggestion 6e6a86
set -U fish_color_selection --background=393552
set -U fish_color_search_match --background=393552
set -U fish_color_valid_path
set -U fish_color_cwd 3e8fb0
set -U fish_color_cwd_root eb6f92
set -U fish_pager_color_progress 6e6a86
set -U fish_pager_color_prefix 9ccfd8
set -U fish_pager_color_completion e0def4
set -U fish_pager_color_description 6e6a86
set -U fish_pager_color_selected_background --background=393552

# --- Platform setup ---
switch (uname)
    case Darwin
        eval "$(/opt/homebrew/bin/brew shellenv)"
        fish_add_path $HOME/.local/bin
    case Linux
        # Linux-specific PATH setup if needed
end

# Navigation
alias ..="cd .."
alias ls="eza --icons"
alias ll="eza -l --icons"
alias la="eza -la --icons"
alias lt="eza --tree --icons"

# Modern cat replacement
alias cat="bat --style=plain"

# Updates (platform-specific)
switch (uname)
    case Darwin
        alias update="brew update && brew upgrade"
        alias clip="pbcopy"
    case Linux
        alias update="sudo pacman -Syu"
        alias aurupdate="yay -Syu"
        alias flatupdate="flatpak update"
end

# System
alias ports="sudo lsof -i -P -n | grep LISTEN"

# Utility
alias c="clear"
alias myip="curl ifconfig.me"

# Platform-specific utilities
switch (uname)
    case Linux
        alias hwinfo="neofetch"
        alias logout="hyprctl dispatch exit"
end

function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

# Applications
alias hx="helix"
alias lg="lazygit"
alias du="dust"
alias z="zoxide query --interactive"

# Git abbreviations (expand in-place so history shows real commands)
abbr -a gs git status
abbr -a gd git diff
abbr -a gl git log --oneline -20
abbr -a gp git push
abbr -a gc git commit
abbr -a ga git add
abbr -a gco git checkout
abbr -a gb git branch

# Platform-specific abbreviations
switch (uname)
    case Linux
        abbr -a pacs sudo pacman -S
        abbr -a pacr sudo pacman -Rns
        abbr -a pacq pacman -Qs
end

# Smart cd replacement
zoxide init fish | source

# Claude Code in tmux
function cc --description 'Start Claude Code in a tmux session'
    set name (basename (pwd))
    tmux new-session -s $name "claude"
end
