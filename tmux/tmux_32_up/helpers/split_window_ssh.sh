source "$(dirname "$(readlink -f "$0")")/helpers.sh"

pane_pid=${1:-$(tmux display -p '#{pane_pid}')}
pane_tty=${2:-$(tmux display -p '#{b:pane_tty}')}
shift 2

pane_info=$(_pane_info "$pane_pid" "$pane_tty")
command=${pane_info#*:}
command=${command#*:}

case "$command" in
  *mosh-client*)
    # shellcheck disable=SC2046
     tmux split-window "$@" mosh $(echo "$command" | sed -E -e 's/.*mosh-client -# (.*)\|.*$/\1/')
   ;;
  *ssh*)
    # shellcheck disable=SC2046
    tmux split-window "$@" $(echo "$command" | sed -e 's/;/\\;/g')
    ;;
  *)
    tmux split-window "$@"
esac