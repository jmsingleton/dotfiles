# Named tmux session shortcuts for mediaserver
function ta --description 'Attach to or create named tmux session'
    tmux new-session -A -s $argv[1]
end

function tls --description 'List tmux sessions'
    tmux list-sessions 2>/dev/null || echo "No sessions"
end

# Quick sessions
alias admin="ta admin"
alias logs="ta logs"

# SSH logins land in a persistent tmux session, so closing the desktop/terminal
# only detaches. Bypass with: ssh -t mediaserver env NO_TMUX=1 fish
# Stow deploys this file everywhere, so only act on the server itself.
if test (hostname) = mediaserver; and status is-interactive; and set -q SSH_TTY; and not set -q TMUX; and not set -q NO_TMUX; and command -q tmux
    exec tmux new-session -A -s main
end
