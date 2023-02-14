pane_pid=${1:-$(tmux display -p '#{pane_pid}')}
pane_tty=${2:-$(tmux display -p '#{b:pane_tty}')}
root=$3

username=$(sh $(dirname "$(readlink -f "$0")")/helpers/username.sh "$pane_id" "$pane_tty" false)
[ x"$username" = x"root" ] && echo "$root"