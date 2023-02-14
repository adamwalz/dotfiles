sh "$(dirname "$(readlink -f "$0")")/theme/plugins/battery_info.sh"
if [ "$charge" = 0 ]; then
  tmux set -ug '@battery_status'
  return
fi

battery_status_charging=$1
battery_status_discharging=$2
if [ x"$discharging" = x"true" ]; then
  battery_status="$battery_status_discharging"
else
  battery_status="$battery_status_charging"
fi

tmux set -g '@battery_status' "$battery_status"