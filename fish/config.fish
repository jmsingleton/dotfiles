# Navigation
alias ..="cd .."
alias ls="eza --icons" # Basic listing with icons
alias ll="eza -l --icons" # Long listing with icons
alias la="eza -la --icons" # All files, long list
alias lt="eza --tree --icons" # Tree view

# Modern cat replacement
alias cat="bat --style=plain"

# Updates
alias update="sudo pacman -Syu"
alias aurupdate="yay -Syu"
alias flatupdate="flatpak update"

# System
alias hwinfo="neofetch"
alias ports="sudo lsof -i -P -n | grep LISTEN"

# Utility
alias c="clear"
alias myip="curl ifconfig.me"
alias logout="hyprctl dispatch exit"

function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

# Applications
alias hx="helix"
alias lg="lazygit"
alias du="dust"
alias z="zoxide query --interactive"

# Abbreviations (expand in-place so history shows real commands)
abbr -a gs git status
abbr -a gd git diff
abbr -a gl git log --oneline -20
abbr -a gp git push
abbr -a gc git commit
abbr -a ga git add
abbr -a gco git checkout
abbr -a gb git branch
abbr -a pacs sudo pacman -S
abbr -a pacr sudo pacman -Rns
abbr -a pacq pacman -Qs

# Smart cd replacement
zoxide init fish | source

# Claude Code in tmux
function cc --description 'Start Claude Code in a tmux session'
    set name (basename (pwd))
    tmux new-session -s $name "claude"
end
