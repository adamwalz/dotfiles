source "$(dirname "$(readlink -f "$0")")/helpers.sh"

pane_pid=${1:-$(tmux display -p '#{pane_pid}')}
pane_tty=${2:-$(tmux display -p '#{b:pane_tty}')}
ssh_only=$3
full=$4
h_or_H=$5

this_pane_info=$(pane_info "$pane_pid" "$pane_tty")
command=${this_pane_info#*:}
command=${command#*:}

ssh_or_mosh_args=$(_ssh_or_mosh_args "$command")
if [ -n "$ssh_or_mosh_args" ]; then
  # shellcheck disable=SC2086
  hostname=$(ssh -G $ssh_or_mosh_args 2>/dev/null | awk '/^hostname / { print $2; exit }')
  # shellcheck disable=SC2086
  [ -z "$hostname" ] && hostname=$(ssh -T -o ControlPath=none -o ProxyCommand="sh -c 'echo %%hostname%% %h >&2'" $ssh_or_mosh_args 2>&1 | awk '/^%hostname% / { print $2; exit }')

  if ! _is_true "$full"; then
    case "$hostname" in
        *[a-z-].*)
            hostname=${hostname%%.*}
            ;;
        127.0.0.1)
            hostname="localhost"
            ;;
    esac
  fi
else
  if ! _is_true "$ssh_only"; then
    hostname="$h_or_H"
  fi
fi

printf '%s\n' "$hostname"