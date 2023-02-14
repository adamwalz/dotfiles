#!/bin/sh

set -e

unset GREP_OPTIONS
export LC_NUMERIC=C
(set +H 2>/dev/null) && set +H || true

printf "Log File - " > /Users/adamwalz/Desktop/tmux.log
date >> /Users/adamwalz/Desktop/tmux.log

apply_configuration() {
  source "$(dirname "$(readlink -f "$0")")/appliers/apply_24b.sh"
  source "$(dirname "$(readlink -f "$0")")/appliers/apply_theme.sh"
  source "$(dirname "$(readlink -f "$0")")/appliers/apply_bindings.sh"
  source "$(dirname "$(readlink -f "$0")")/appliers/apply_plugins.sh"
  source "$(dirname "$(readlink -f "$0")")/appliers/apply_important.sh"

  window_active="$(tmux display -p '#{window_active}' 2>/dev/null || true)"
  if [ -z "$window_active" ]; then
    if ! command -v perl > /dev/null 2>&1; then
      tmux run -b 'tmux set display-time 3000 \; display "This configuration requires perl" \; set -u display-time \; run "sleep 3" \; kill-server'
      return
    fi
    if ! command -v sed > /dev/null 2>&1; then
      tmux run -b 'tmux set display-time 3000 \; display "This configuration requires sed" \; set -u display-time \; run "sleep 3" \; kill-server'
      return
    fi
    if ! command -v awk > /dev/null 2>&1; then
      tmux run -b 'tmux set display-time 3000 \; display "This configuration requires awk" \; set -u display-time \; run "sleep 3" \; kill-server'
      return
    fi
  fi

  # see https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard
  if command -v reattach-to-user-namespace > /dev/null 2>&1; then
    default_shell="$(tmux show -gv default-shell)"
    case "$default_shell" in
      *fish)
        tmux set -g default-command "reattach-to-user-namespace -l $default_shell"
        ;;
      *sh)
        tmux set -g default-command "exec $default_shell... 2> /dev/null & reattach-to-user-namespace -l $default_shell"
        ;;
    esac
  fi

  case `uname -s` in
    *CYGWIN*|*MSYS*)
      # prevent Cygwin and MSYS2 from cd-ing into home directory when evaluating /etc/profile
      tmux setenv -g CHERE_INVOKING 1
      ;;
  esac

  apply_24b
  apply_theme&
  apply_bindings&
  wait

  apply_plugins $window_active $tmux_conf_update_plugins_on_launch $tmux_conf_update_plugins_on_reload $tmux_conf_uninstall_plugins_on_reload
  apply_important

  # shellcheck disable=SC2046
  tmux setenv -gu tmux_conf_dummy $(printenv | grep -E -o '^tmux_conf_[^=]+' | awk '{printf "; setenv -gu %s", $0}')
}

"$@"
