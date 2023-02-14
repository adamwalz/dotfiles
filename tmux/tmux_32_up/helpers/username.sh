source "$(dirname "$(readlink -f "$0")")/helpers.sh"

pane_pid=${1:-$(tmux display -p '#{pane_pid}')}
pane_tty=${2:-$(tmux display -p '#{b:pane_tty}')}
ssh_only=$3

this_pane_info=$(pane_info "$pane_pid" "$pane_tty")

command=${this_pane_info#*:}
command=${command#*:}

this_ssh_or_mosh_args=$(ssh_or_mosh_args "$command")
if [ -n "$this_ssh_or_mosh_args" ]; then
  # shellcheck disable=SC2086
  username=$(ssh -G $this_ssh_or_mosh_args 2>/dev/null | awk '/^user / { print $2; exit }')
  # shellcheck disable=SC2086
  [ -z "$username" ] && username=$(ssh $this_ssh_or_mosh_args -T -o ControlPath=none -o ProxyCommand="sh -c 'echo %%username%% %r >&2'" 2>&1 | awk '/^%username% / { print $2; exit }')
  [ -z "$username" ] && username=$(ssh $this_ssh_or_mosh_args -v -T -o ControlPath=none -o ProxyCommand=false -o IdentityFile='%%username%%/%r' 2>&1 | awk '/%username%/ { print substr($4,12); exit }')
else
  if ! is_true "$ssh_only"; then
    username=${this_pane_info#*:}
    username=${username%%:*}
  fi
fi

printf '%s\n' "$username"