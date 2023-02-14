case `uname -s` in
  *Darwin*|*FreeBSD*)
    boot=$(sysctl -q -n kern.boottime | awk -F'[ ,:]+' '{ print $4 }')
    now=$(date +%s)
    ;;
  *Linux*|*CYGWIN*|*MSYS*|*MINGW*)
    boot=0
    now=$(cut -d' ' -f1 < /proc/uptime)
    ;;
  *OpenBSD*)
    boot=$(sysctl -n kern.boottime)
    now=$(date +%s)
esac
# shellcheck disable=SC1004
awk -v boot="$boot" -v now="$now" '
  BEGIN {
    uptime = now - boot
    y = int(uptime / 31536000)
    dy = int(uptime / 86400) % 365
    d = int(uptime / 86400)
    h = int(uptime / 3600) % 24
    m = int(uptime / 60) % 60
    s = int(uptime) % 60

    system("tmux  set -g @uptime_y " y + 0 " \\; " \
                 "set -g @uptime_dy " dy + 0 " \\; " \
                 "set -g @uptime_d " d + 0 " \\; " \
                 "set -g @uptime_h " h + 0 " \\; " \
                 "set -g @uptime_m " m + 0 " \\; " \
                 "set -g @uptime_s " s + 0)
  }'