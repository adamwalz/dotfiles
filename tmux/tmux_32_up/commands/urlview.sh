# Find urls in pane and open in browser
tmux capture-pane -J -S - -E - -b "urlview-$1" -t "$1"
tmux split-window "tmux show-buffer -b urlview-$1 | urlview || true; tmux delete-buffer -b urlview-$1"