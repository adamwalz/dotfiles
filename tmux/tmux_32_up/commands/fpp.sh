# Facebook Path Picker
tmux capture-pane -J -S - -E - -b "fpp-$1" -t "$1"
tmux split-window -c $2 "tmux show-buffer -b fpp-$1 | fpp || true; tmux delete-buffer -b fpp-$1"