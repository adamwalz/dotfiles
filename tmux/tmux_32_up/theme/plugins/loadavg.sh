case `uname -s` in
  *Darwin*|*FreeBSD*)
    tmux set -g @loadavg "$(sysctl -q -n vm.loadavg | cut -d' ' -f2)"
    ;;
  *Linux*|*CYGWIN*)
    tmux set -g @loadavg "$(cut -d' ' -f1 < /proc/loadavg)"
    ;;
  *OpenBSD*)
    tmux set -g @loadavg "$(sysctl -q -n vm.loadavg | cut -d' ' -f1)"
    ;;
esac