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
