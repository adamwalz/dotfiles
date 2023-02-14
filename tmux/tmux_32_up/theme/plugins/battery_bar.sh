_battery_info
if [ "$charge" = 0 ]; then
  tmux  set -ug '@battery_bar'     \;\
        set -ug '@battery_hbar'    \;\
        set -ug '@battery_vbar'    \;\
        set -ug '@battery_percentage'
  return
fi

battery_bar_symbol_full=$1
battery_bar_symbol_empty=$2
battery_bar_length=$3
battery_bar_palette=$4
battery_hbar_palette=$5
battery_vbar_palette=$6

if [ x"$battery_bar_length" = x"auto" ]; then
  columns=$(tmux -q display -p '#{client_width}' 2> /dev/null || echo 80)
  if [ "$columns" -ge 80 ]; then
    battery_bar_length=10
  else
    battery_bar_length=5
  fi
fi

if echo "$battery_bar_palette" | grep -q -E '^heat|gradient(,[#a-z0-9]{7,9})?$'; then
  # shellcheck disable=SC2086
  { set -f; IFS=,; set -- $battery_bar_palette; unset IFS; set +f; }
  palette_style=$1
  battery_bg=${2:-none}
  [ x"$palette_style" = x"gradient" ] && \
    palette="196 202 208 214 220 226 190 154 118 82 46"
  [ x"$palette_style" = x"heat" ] && \
    palette="243 245 247 144 143 142 184 214 208 202 196"

  palette=$(echo "$palette" | awk -v n="$battery_bar_length" '{ for (i = 0; i < n; ++i) printf $(1 + (i * NF / n))" " }')
  eval set -- "$palette"

  full=$(awk "BEGIN { printf \"%.0f\", ($charge) * $battery_bar_length }")
  battery_bar="#[bg=$battery_bg]"
  # shellcheck disable=SC2046
  [ "$full" -gt 0 ] && \
    battery_bar="$battery_bar$(printf "#[fg=colour%s]$battery_bar_symbol_full" $(echo "$palette" | cut -d' ' -f1-"$full"))"
  # shellcheck disable=SC2046
  empty=$((battery_bar_length - full))
  # shellcheck disable=SC2046
  [ "$empty" -gt 0 ] && \
    battery_bar="$battery_bar$(printf "#[fg=colour%s]$battery_bar_symbol_empty" $(echo "$palette" | cut -d' ' -f$((full + 1))-$((full + empty))))"
    eval battery_bar="$battery_bar#[fg=colour\${$((full == 0 ? 1 : full))}]"
elif echo "$battery_bar_palette" | grep -q -E '^(([#a-z0-9]{7,9}|none),?){3}$'; then
  # shellcheck disable=SC2086
  { set -f; IFS=,; set -- $battery_bar_palette; unset IFS; set +f; }
  battery_full_fg=$1
  battery_empty_fg=$2
  battery_bg=$3

  full=$(awk "BEGIN { printf \"%.0f\", ($charge) * $battery_bar_length }")
  [ x"$battery_bg" != x"none" ] && \
    battery_bar="#[bg=$battery_bg]"
  #shellcheck disable=SC2046
  [ "$full" -gt 0 ] && \
    battery_bar="$battery_bar#[fg=$battery_full_fg]$(printf "%0.s$battery_bar_symbol_full" $(seq 1 "$full"))"
  empty=$((battery_bar_length - full))
  #shellcheck disable=SC2046
  [ "$empty" -gt 0 ] && \
    battery_bar="$battery_bar#[fg=$battery_empty_fg]$(printf "%0.s$battery_bar_symbol_empty" $(seq 1 "$empty"))" && \
    battery_bar="$battery_bar#[fg=$battery_empty_fg]"
fi

if echo "$battery_hbar_palette" | grep -q -E '^heat|gradient(,[#a-z0-9]{7,9})?$'; then
  # shellcheck disable=SC2086
  { set -f; IFS=,; set -- $battery_hbar_palette; unset IFS; set +f; }
  palette_style=$1
  [ x"$palette_style" = x"gradient" ] && \
    palette="196 202 208 214 220 226 190 154 118 82 46"
  [ x"$palette_style" = x"heat" ] && \
    palette="233 234 235 237 239 241 243 245 247 144 143 142 184 214 208 202 196"

  palette=$(echo "$palette" | awk -v n="$battery_bar_length" '{ for (i = 0; i < n; ++i) printf $(1 + (i * NF / n))" " }')
  eval set -- "$palette"

  full=$(awk "BEGIN { printf \"%.0f\", ($charge) * $battery_bar_length }")
  eval battery_hbar_fg="colour\${$((full == 0 ? 1 : full))}"
elif echo "$battery_hbar_palette" | grep -q -E '^([#a-z0-9]{7,9},?){3}$'; then
  # shellcheck disable=SC2086
  { set -f; IFS=,; set -- $battery_hbar_palette; unset IFS; set +f; }

  # shellcheck disable=SC2046
  eval $(awk "BEGIN { printf \"battery_hbar_fg=$%d\", (($charge) - 0.001) * $# + 1 }")
fi

eval set -- "▏ ▎ ▍ ▌ ▋ ▊ ▉ █"
# shellcheck disable=SC2046
eval $(awk "BEGIN { printf \"battery_hbar_symbol=$%d\", ($charge) * ($# - 1) + 1 }")
battery_hbar="#[fg=${battery_hbar_fg?}]${battery_hbar_symbol?}"

if echo "$battery_vbar_palette" | grep -q -E '^heat|gradient(,[#a-z0-9]{7,9})?$'; then
  # shellcheck disable=SC2086
  { set -f; IFS=,; set -- $battery_vbar_palette; unset IFS; set +f; }
  palette_style=$1
  [ x"$palette_style" = x"gradient" ] && \
    palette="196 202 208 214 220 226 190 154 118 82 46"
  [ x"$palette_style" = x"heat" ] && \
    palette="233 234 235 237 239 241 243 245 247 144 143 142 184 214 208 202 196"

  palette=$(echo "$palette" | awk -v n="$battery_bar_length" '{ for (i = 0; i < n; ++i) printf $(1 + (i * NF / n))" " }')
  eval set -- "$palette"

  full=$(awk "BEGIN { printf \"%.0f\", ($charge) * $battery_bar_length }")
  eval battery_vbar_fg="colour\${$((full == 0 ? 1 : full))}"
elif echo "$battery_vbar_palette" | grep -q -E '^([#a-z0-9]{7,9},?){3}$'; then
  # shellcheck disable=SC2086
  { set -f; IFS=,; set -- $battery_vbar_palette; unset IFS; set +f; }

  # shellcheck disable=SC2046
  eval $(awk "BEGIN { printf \"battery_vbar_fg=$%d\", (($charge) - 0.001) * $# + 1 }")
fi

eval set -- "▁ ▂ ▃ ▄ ▅ ▆ ▇ █"
# shellcheck disable=SC2046
eval $(awk "BEGIN { printf \"battery_vbar_symbol=$%d\", ($charge) * ($# - 1) + 1 }")
battery_vbar="#[fg=${battery_vbar_fg?}]${battery_vbar_symbol?}"

battery_percentage="$(awk "BEGIN { printf \"%.0f%%\", ($charge) * 100 }")"

tmux  set -g '@battery_status' "$battery_status" \;\
      set -g '@battery_bar' "$battery_bar" \;\
      set -g '@battery_hbar' "$battery_hbar" \;\
      set -g '@battery_vbar' "$battery_vbar" \;\
      set -g '@battery_percentage' "$battery_percentage"