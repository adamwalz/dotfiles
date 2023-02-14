is_true() {
  [ x"$1" = x"true" ] || [ x"$1" = x"yes" ] || [ x"$1" = x"1" ]
}

is_enabled() {
  [ x"$1" = x"enabled" ]
}

is_disabled() {
  [ x"$1" = x"disabled" ]
}

if ! printf '' | sed -E 's///' 2>/dev/null; then
  if printf '' | sed -r 's///' 2>/dev/null; then
    sed () {
      n=$#; while [ "$n" -gt 0 ]; do arg=$1; shift; case $arg in -E*) arg=-r${arg#-E};; esac; set -- "$@" "$arg"; n=$(( n - 1 )); done
      command sed "$@"
    }
  fi
fi

if command -v pkill > /dev/null 2>&1; then
  pkillf() {
    pkill -f "$@" || true
  }
else
  case `uname -s` in
    *CYGWIN*)
      pkillf() {
        while IFS= read -r pid; do
          kill "$pid" || true
        done  << EOF
$(grep -Eao "$@" /proc/*/cmdline | xargs -0 | sed -E -n 's,/proc/([0-9]+)/.+$,\1,pg')
EOF
      }
      ;;
    *)
      pkillf() {
        while IFS= read -r pid; do
          kill "$pid" || true
        done  << EOF
$(ps -x -o pid= -o command= | grep -E "$@" | cut -d' ' -f1)
EOF
      }
      ;;
  esac
fi

decode_unicode_escapes() {
  printf '%s' "$*" | perl -CS -pe 's/(\\u([0-9A-Fa-f]{1,4})|\\U([0-9A-Fa-f]{1,8}))/chr(hex($2.$3))/eg' 2>/dev/null
}

is_dark_mode_enabled() {
  # Check default on macos
  if command -v defaults > /dev/null 2>&1; then
    dark=$(defaults read -g AppleInterfaceStyle 2> /dev/null)
    if [ "$dark" = "Dark" ]; then
      return 0
    fi
  fi
  # Check environment variable on ssh
  if [ "$SSH_DARK_MODE" == "1" ] || [ "$SSH_DARK_MODE" == "on" ] || [ "$SSH_DARK_MODE" == "dark" ]; then
      return 0
  fi
  # Check file as last resort
  if test -f ~/.darkmode; then
    return 0
  fi
  return 1
}

pane_info() {
  pane_pid="$1"
  pane_tty="${2##/dev/}"
  echo "got to pane_info" >> /Users/adamwalz/Desktop/tmux.log
  case `uname -s` in
    *CYGWIN*)
      echo "got to pane_info CYGWIN" >> /Users/adamwalz/Desktop/tmux.log
      ps -al | tail -n +2 | awk -v pane_pid="$pane_pid" -v tty="$pane_tty" '
        ((/ssh/ && !/-W/) || !/ssh/) && !/tee/ && $5 == tty {
          user[$1] = $6; if (!child[$2]) child[$2] = $1
        }
        END {
          pid = pane_pid
          while (child[pid])
            pid = child[pid]

          file = "/proc/" pid "/cmdline"; getline command < file; close(file)
          gsub(/\0/, " ", command)
          "id -un " user[pid] | getline username
          print pid":"username":"command
        }
      '
      ;;
    *Linux*)
      echo "got to pane_info Linux" >> /Users/adamwalz/Desktop/tmux.log
      ps -t "$pane_tty" --sort=lstart -o user=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -o pid= -o ppid= -o command= | awk -v pane_pid="$pane_pid" '
        ((/ssh/ && !/-W/) || !/ssh/) && !/tee/ {
          user[$2] = $1; if (!child[$3]) child[$3] = $2; pid=$2; $1 = $2 = $3 = ""; command[pid] = substr($0,4)
        }
        END {
          pid = pane_pid
          while (child[pid])
            pid = child[pid]

          print pid":"user[pid]":"command[pid]
        }
      '
      ;;
    *)
      echo "got to pane_info *" >> /Users/adamwalz/Desktop/tmux.log
      ps -t "$pane_tty" -o user=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -o pid= -o ppid= -o command= | awk -v pane_pid="$pane_pid" '
        ((/ssh/ && !/-W/) || !/ssh/) && !/tee/ {
          user[$2] = $1; if (!child[$3]) child[$3] = $2; pid=$2; $1 = $2 = $3 = ""; command[pid] = substr($0,4)
        }
        END {
          pid = pane_pid
          while (child[pid])
            pid = child[pid]

          print pid":"user[pid]":"command[pid]
        }
      '
      ;;
  esac
}

ssh_or_mosh_args() {
  case "$1" in
    *ssh*)
      args=$(printf '%s' "$1" | perl -n -e 'print if s/.*?\bssh[\w]*\s*((?:\s+-\w+)*)(\s+\w+)(\s\w+)?/\1\2/')
      ;;
    *mosh-client*)
      args=$(printf '%s' "$1" | sed -E -e 's/.*mosh-client -# (.*)\|.*$/\1/' -e 's/-[^ ]*//g' -e 's/\d:\d//g')
      ;;
  esac

 printf '%s' "$args"
}