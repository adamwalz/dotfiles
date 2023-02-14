count=0
charge=0
case `uname -s` in
  *Darwin*)
    while IFS= read -r line; do
      [ -z "$line" ] && continue
      discharging=$(printf '%s' "$line" | grep -qi "discharging" && echo "true" || echo "false")
      percentage=$(printf '%s' "$line" | grep -E -o '[0-9]+%' || echo "0%")
      charge=$(awk -v charge="$charge" -v percentage="${percentage%%%}" 'BEGIN { print charge + percentage / 100 }')
      count=$((count + 1))
    done  << EOF
$(pmset -g batt | grep 'InternalBattery')
EOF
    ;;
  *Linux*)
    while IFS= read -r batpath; do
      [ -z "$batpath" ] && continue
      grep -i -q device "$batpath/scope" 2> /dev/null && continue

      discharging=$(grep -qi "discharging" "$batpath/status" && echo "true" || echo "false")
      bat_capacity="$batpath/capacity"
      if [ -r "$bat_capacity" ]; then
        charge=$(awk -v charge="$charge" -v capacity="$(cat "$bat_capacity")" 'BEGIN { print charge + (capacity > 100 ? 100 : capacity) / 100 }')
      else
        bat_energy_full="$batpath/energy_full"
        bat_energy_now="$batpath/energy_now"
        if [ -r "$bat_energy_full" ] && [ -r "$bat_energy_now" ]; then
          charge=$(awk -v charge="$charge" -v energy_now="$(cat "$bat_energy_now")" -v energy_full="$(cat "$bat_energy_full")" 'BEGIN { print charge + energy_now / energy_full }')
        fi
      fi
      count=$((count + 1))
    done  << EOF
$(find /sys/class/power_supply -maxdepth 1 -iname '*bat*')
EOF
    ;;
  *CYGWIN*|*MSYS*|*MINGW*)
    while IFS= read -r line; do
      [ -z "$line" ] && continue
      discharging=$(printf '%s' "$line" | awk '{ s = ($1 == 1) ? "true" : "false"; print s }')
      charge=$(printf '%s' "$line" | awk -v charge="$charge" '{ print charge + $2 / 100 }')
      count=$((count + 1))
    done  << EOF
$(wmic path Win32_Battery get BatteryStatus, EstimatedChargeRemaining 2> /dev/null | tr -d '\r' | tail -n +2 || true)
EOF
    ;;
  *OpenBSD*)
    for batid in 0 1 2; do
      sysctl -n "hw.sensors.acpibat$batid.raw0" 2>&1 | grep -q 'not found' && continue
      discharging=$(sysctl -n "hw.sensors.acpibat$batid.raw0" | grep -q 1 && echo "true" || echo "false")
      if sysctl -n "hw.sensors.acpibat$batid" | grep -q amphour; then
        charge=$(awk -v charge="$charge" -v remaining="$(sysctl -n hw.sensors.acpibat$batid.amphour3 | cut -d' ' -f1)" -v full="$(sysctl -n hw.sensors.acpibat$batid.amphour0 | cut -d' ' -f1)" 'BEGIN { print charge + remaining / full }')
      else
        charge=$(awk -v charge="$charge" -v remaining="$(sysctl -n hw.sensors.acpibat$batid.watthour3 | cut -d' ' -f1)" -v full="$(sysctl -n hw.sensors.acpibat$batid.watthour0 | cut -d' ' -f1)" 'BEGIN { print charge + remaining / full }')
      fi
      count=$((count + 1))
    done
    ;;
esac
[ "$count" -ne 0 ] && charge=$(awk -v charge="$charge" -v count="$count" 'BEGIN { print charge / count }') || true