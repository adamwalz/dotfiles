apply_theme() {

  echo "got to apply_theme" >> /Users/adamwalz/Desktop/tmux.log
  source "$(dirname "$(readlink -f "$0")")/helpers/helpers.sh"
  source "$(dirname "$(readlink -f "$0")")/theme/variables.sh"

  if [ -n "$tmux_conf_theme_status_left_light" ]; then
    status_left_light=$(echo "$tmux_conf_theme_status_left_light" | sed \
      -e "s/#{pairing}/#[fg=$tmux_conf_theme_pairing_fg_light]#[bg=$tmux_conf_theme_pairing_bg_light]#[$tmux_conf_theme_pairing_attr]#{?session_many_attached,$tmux_conf_theme_pairing_light ,}/g" \
      -e "s/#{prefix}/#[fg=$tmux_conf_theme_prefix_fg_light]#[bg=$tmux_conf_theme_prefix_bg_light]#[$tmux_conf_theme_prefix_attr]#{?client_prefix,$tmux_conf_theme_prefix ,$(printf "$tmux_conf_theme_prefix" | sed -e 's/./ /g') }/g" \
      -e "s/#{mouse}/#[fg=$tmux_conf_theme_mouse_fg_light]#[bg=$tmux_conf_theme_mouse_bg_light]#[$tmux_conf_theme_mouse_attr]#{?mouse,$tmux_conf_theme_mouse ,$(printf "$tmux_conf_theme_mouse" | sed -e 's/./ /g') }/g" \
      -e "s%#{synchronized}%#[fg=$tmux_conf_theme_synchronized_fg_light]#[bg=$tmux_conf_theme_synchronized_bg_light]#[$tmux_conf_theme_synchronized_attr]#{?pane_synchronized,$tmux_conf_theme_synchronized ,}%g" \
      -e 's%#{circled_session_name}%#(~/.tmux/tmux_32_up/helpers/circled.sh #S)%g')

    if [ -n "$(tmux display -p '#{version}')" ]; then
      status_left_light=$(echo "$status_left_light" | sed \
        -e "s%#{root}%#[fg=$tmux_conf_theme_root_fg_light]#[bg=$tmux_conf_theme_root_bg_light]#[$tmux_conf_theme_root_attr]#{?#{==:#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} #D),root},$tmux_conf_theme_root,}#[inherit]%g")
    else
      status_left_light=$(echo "$status_left_light" | sed \
        -e "s%#{root}%#[fg=$tmux_conf_theme_root_fg_light]#[bg=$tmux_conf_theme_root_bg_light]#[$tmux_conf_theme_root_attr]#(~/.tmux/tmux_32_up/theme/plugins/root.sh #{pane_pid} #{b:pane_tty} $tmux_conf_theme_root #D)#[inherit]%g")
    fi

    status_left_light=$(printf '%s' "$status_left_light" | awk -f "$(dirname "$(readlink -f "$0")")/appliers/status_left_formatter.awk" \
                      -v status_bg="$tmux_conf_theme_status_bg_light" \
                      -v fg_="$tmux_conf_theme_status_left_fg_light" \
                      -v bg_="$tmux_conf_theme_status_left_bg_light" \
                      -v attr_="$tmux_conf_theme_status_left_attr" \
                      -v mainsep="$tmux_conf_theme_left_separator_main" \
                      -v subsep="$tmux_conf_theme_left_separator_sub")
  fi

  status_left_light="$status_left_light "

  if [ -n "$tmux_conf_theme_status_left_dark" ]; then
    status_left_dark=$(echo "$tmux_conf_theme_status_left_dark" | sed \
      -e "s/#{pairing}/#[fg=$tmux_conf_theme_pairing_fg_dark]#[bg=$tmux_conf_theme_pairing_bg_dark]#[$tmux_conf_theme_pairing_attr]#{?session_many_attached,$tmux_conf_theme_pairing_dark ,}/g" \
      -e "s/#{prefix}/#[fg=$tmux_conf_theme_prefix_fg_dark]#[bg=$tmux_conf_theme_prefix_bg_dark]#[$tmux_conf_theme_prefix_attr]#{?client_prefix,$tmux_conf_theme_prefix ,$(printf "$tmux_conf_theme_prefix" | sed -e 's/./ /g') }/g" \
      -e "s/#{mouse}/#[fg=$tmux_conf_theme_mouse_fg_dark]#[bg=$tmux_conf_theme_mouse_bg_dark]#[$tmux_conf_theme_mouse_attr]#{?mouse,$tmux_conf_theme_mouse ,$(printf "$tmux_conf_theme_mouse" | sed -e 's/./ /g') }/g" \
      -e "s%#{synchronized}%#[fg=$tmux_conf_theme_synchronized_fg_dark]#[bg=$tmux_conf_theme_synchronized_bg_dark]#[$tmux_conf_theme_synchronized_attr]#{?pane_synchronized,$tmux_conf_theme_synchronized ,}%g" \
      -e 's%#{circled_session_name}%#(~/.tmux/tmux_32_up/helpers/circled.sh #S)%g')

    if [ -n "$(tmux display -p '#{version}')" ]; then
      status_left_dark=$(echo "$status_left_dark" | sed \
        -e "s%#{root}%#[fg=$tmux_conf_theme_root_fg_dark]#[bg=$tmux_conf_theme_root_bg_dark]#[$tmux_conf_theme_root_attr]#{?#{==:#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} #D),root},$tmux_conf_theme_root,}#[inherit]%g")
    else
      status_left_dark=$(echo "$status_left_dark" | sed \
        -e "s%#{root}%#[fg=$tmux_conf_theme_root_fg_dark]#[bg=$tmux_conf_theme_root_bg_dark]#[$tmux_conf_theme_root_attr]#(~/.tmux/tmux_32_up/theme/plugins/root.sh #{pane_pid} #{b:pane_tty} $tmux_conf_theme_root #D)#[inherit]%g")
    fi

    status_left_dark=$(printf '%s' "$status_left_dark" | awk -f "$(dirname "$(readlink -f "$0")")/appliers/status_left_formatter.awk" \
                      -v status_bg="$tmux_conf_theme_status_bg_dark" \
                      -v fg_="$tmux_conf_theme_status_left_fg_dark" \
                      -v bg_="$tmux_conf_theme_status_left_bg_dark" \
                      -v attr_="$tmux_conf_theme_status_left_attr" \
                      -v mainsep="$tmux_conf_theme_left_separator_main" \
                      -v subsep="$tmux_conf_theme_left_separator_sub")
  fi

  status_left_dark="$status_left_dark "

  # -- status-right style

  tmux_conf_theme_status_right_light=${tmux_conf_theme_status_right_light-' #{prefix}#{mouse}#{pairing}#{synchronized}#{?battery_status, #{battery_status},}#{?battery_bar, #{battery_bar},}#{?battery_percentage, #{battery_percentage},} , %R , %d %b | #{username}#{root} | #{hostname} '}
  tmux_conf_theme_status_right_dark=${tmux_conf_theme_status_right_dark-' #{prefix}#{mouse}#{pairing}#{synchronized}#{?battery_status, #{battery_status},}#{?battery_bar, #{battery_bar},}#{?battery_percentage, #{battery_percentage},} , %R , %d %b | #{username}#{root} | #{hostname} '}
  tmux_conf_theme_status_right_fg_light=${tmux_conf_theme_status_right_fg_light:-colour245,colour254,colour232}
  tmux_conf_theme_status_right_fg_dark=${tmux_conf_theme_status_right_fg_dark:-colour245,colour254,colour232}
  tmux_conf_theme_status_right_bg_light=${tmux_conf_theme_status_right_bg_light:-colour232,colour160,colour254}
  tmux_conf_theme_status_right_bg_dark=${tmux_conf_theme_status_right_bg_dark:-colour232,colour160,colour254}
  tmux_conf_theme_status_right_attr=${tmux_conf_theme_status_right_attr:-none,none,bold}

  if [ -n "$tmux_conf_theme_status_right_light" ]; then
    status_right_light=$(echo "$tmux_conf_theme_status_right_light" | sed \
      -e "s/#{pairing}/#[fg=$tmux_conf_theme_pairing_fg_light]#[bg=$tmux_conf_theme_pairing_bg_light]#[$tmux_conf_theme_pairing_attr]#{?session_many_attached,$tmux_conf_theme_pairing ,}/g" \
      -e "s/#{prefix}/#[fg=$tmux_conf_theme_prefix_fg_light]#[bg=$tmux_conf_theme_prefix_bg_light]#[$tmux_conf_theme_prefix_attr]#{?client_prefix,$tmux_conf_theme_prefix ,$(printf "$tmux_conf_theme_prefix" | sed -e 's/./ /g') }/g" \
      -e "s/#{mouse}/#[fg=$tmux_conf_theme_mouse_fg_light]#[bg=$tmux_conf_theme_mouse_bg_light]#[$tmux_conf_theme_mouse_attr]#{?mouse,$tmux_conf_theme_mouse ,$(printf "$tmux_conf_theme_mouse" | sed -e 's/./ /g') }/g" \
      -e "s%#{synchronized}%#[fg=$tmux_conf_theme_synchronized_fg_light]#[bg=$tmux_conf_theme_synchronized_bg_light]#[$tmux_conf_theme_synchronized_attr]#{?pane_synchronized,$tmux_conf_theme_synchronized ,}%g" \
      -e 's%#{circled_session_name}%#(~/.tmux/tmux_32_up/helpers/circled.sh #S)%g')

    if [ -z "$(tmux display -p '#{version}')" ]; then
      status_right_light=$(echo "$status_right_light" | sed \
        -e "s%#{root}%#[fg=$tmux_conf_theme_root_fg_light]#[bg=$tmux_conf_theme_root_bg_light]#[$tmux_conf_theme_root_attr]#{?#{==:#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} #D),root},$tmux_conf_theme_root,}#[inherit]%g")
    else
      status_right_light=$(echo "$status_right_light" | sed \
        -e "s%#{root}%#[fg=$tmux_conf_theme_root_fg_light]#[bg=$tmux_conf_theme_root_bg_light]#[$tmux_conf_theme_root_attr]#(~/.tmux/tmux_32_up/theme/plugins/root.sh #{pane_pid} #{b:pane_tty} $tmux_conf_theme_root #D)#[inherit]%g")
    fi

    status_right_light=$(printf '%s' "$status_right_light" | awk -f "$(dirname "$(readlink -f "$0")")/appliers/status_right_formatter.awk" \
                      -v status_bg="$tmux_conf_theme_status_bg_light" \
                      -v fg_="$tmux_conf_theme_status_right_fg_light" \
                      -v bg_="$tmux_conf_theme_status_right_bg_light" \
                      -v attr_="$tmux_conf_theme_status_right_attr" \
                      -v mainsep="$tmux_conf_theme_right_separator_main" \
                      -v subsep="$tmux_conf_theme_right_separator_sub")
  fi

  tmux_conf_theme_status_right_light=${tmux_conf_theme_status_right_light-' #{prefix}#{mouse}#{pairing}#{synchronized}#{?battery_status, #{battery_status},}#{?battery_bar, #{battery_bar},}#{?battery_percentage, #{battery_percentage},} , %R , %d %b | #{username}#{root} | #{hostname} '}
  tmux_conf_theme_status_right_dark=${tmux_conf_theme_status_right_dark-' #{prefix}#{mouse}#{pairing}#{synchronized}#{?battery_status, #{battery_status},}#{?battery_bar, #{battery_bar},}#{?battery_percentage, #{battery_percentage},} , %R , %d %b | #{username}#{root} | #{hostname} '}
  tmux_conf_theme_status_right_fg_light=${tmux_conf_theme_status_right_fg_light:-colour245,colour254,colour232}
  tmux_conf_theme_status_right_fg_dark=${tmux_conf_theme_status_right_fg_dark:-colour245,colour254,colour232}
  tmux_conf_theme_status_right_bg_light=${tmux_conf_theme_status_right_bg_light:-colour232,colour160,colour254}
  tmux_conf_theme_status_right_bg_dark=${tmux_conf_theme_status_right_bg_dark:-colour232,colour160,colour254}
  tmux_conf_theme_status_right_attr=${tmux_conf_theme_status_right_attr:-none,none,bold}


  if [ -n "$tmux_conf_theme_status_right_dark" ]; then
    status_right_dark=$(echo "$tmux_conf_theme_status_right_dark" | sed \
      -e "s/#{pairing}/#[fg=$tmux_conf_theme_pairing_fg_dark]#[bg=$tmux_conf_theme_pairing_bg_dark]#[$tmux_conf_theme_pairing_attr]#{?session_many_attached,$tmux_conf_theme_pairing ,}/g" \
      -e "s/#{prefix}/#[fg=$tmux_conf_theme_prefix_fg_dark]#[bg=$tmux_conf_theme_prefix_bg_dark]#[$tmux_conf_theme_prefix_attr]#{?client_prefix,$tmux_conf_theme_prefix ,$(printf "$tmux_conf_theme_prefix" | sed -e 's/./ /g') }/g" \
      -e "s/#{mouse}/#[fg=$tmux_conf_theme_mouse_fg_dark]#[bg=$tmux_conf_theme_mouse_bg_dark]#[$tmux_conf_theme_mouse_attr]#{?mouse,$tmux_conf_theme_mouse ,$(printf "$tmux_conf_theme_mouse" | sed -e 's/./ /g') }/g" \
      -e "s%#{synchronized}%#[fg=$tmux_conf_theme_synchronized_fg_dark]#[bg=$tmux_conf_theme_synchronized_bg_dark]#[$tmux_conf_theme_synchronized_attr]#{?pane_synchronized,$tmux_conf_theme_synchronized ,}%g" \
      -e 's%#{circled_session_name}%#(~/.tmux/tmux_32_up/helpers/circled.sh #S)%g')

    if [ -z "$(tmux display -p '#{version}')" ]; then
      status_right_dark=$(echo "$status_right_dark" | sed \
        -e "s%#{root}%#[fg=$tmux_conf_theme_root_fg_dark]#[bg=$tmux_conf_theme_root_bg_dark]#[$tmux_conf_theme_root_attr]#{?#{==:#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} #D),root},$tmux_conf_theme_root,}#[inherit]%g")
    else
      status_right_dark=$(echo "$status_right_dark" | sed \
        -e "s%#{root}%#[fg=$tmux_conf_theme_root_fg_dark]#[bg=$tmux_conf_theme_root_bg_dark]#[$tmux_conf_theme_root_attr]#(~/.tmux/tmux_32_up/theme/plugins/root.sh #{pane_pid} #{b:pane_tty} $tmux_conf_theme_root #D)#[inherit]%g")
    fi

    status_right_dark=$(printf '%s' "$status_right_dark" | awk -f "$(dirname "$(readlink -f "$0")")/appliers/status_right_formatter.awk" \
                      -v status_bg="$tmux_conf_theme_status_bg_dark" \
                      -v fg_="$tmux_conf_theme_status_right_fg_dark" \
                      -v bg_="$tmux_conf_theme_status_right_bg_dark" \
                      -v attr_="$tmux_conf_theme_status_right_attr" \
                      -v mainsep="$tmux_conf_theme_right_separator_main" \
                      -v subsep="$tmux_conf_theme_right_separator_sub")
  fi

  echo "got to variables" >> /Users/adamwalz/Desktop/tmux.log
  # -- variables

  tmux_conf_battery_bar_symbol_full=$(decode_unicode_escapes "${tmux_conf_battery_bar_symbol_full:-◼}")
  tmux_conf_battery_bar_symbol_empty=$(decode_unicode_escapes "${tmux_conf_battery_bar_symbol_empty:-◻}")
  tmux_conf_battery_bar_length=${tmux_conf_battery_bar_length:-auto}
  tmux_conf_battery_bar_palette=${tmux_conf_battery_bar_palette:-gradient}
  tmux_conf_battery_hbar_palette=${tmux_conf_battery_hbar_palette:-gradient}
  tmux_conf_battery_vbar_palette=${tmux_conf_battery_vbar_palette:-gradient}
  tmux_conf_battery_status_charging=$(decode_unicode_escapes "${tmux_conf_battery_status_charging:-↑}")        # U+2191
  tmux_conf_battery_status_discharging=$(decode_unicode_escapes "${tmux_conf_battery_status_discharging:-↓}")  # U+2193

  echo "got to battery_bar" >> /Users/adamwalz/Desktop/tmux.log
  pkillf '~/\.tmux/tmux_32_up/theme/plugins/battery_bar\.sh'
  sh "$(dirname "$(readlink -f "$0")")/theme/plugins/battery_info.sh"
  if [ "$charge" != 0 ]; then
    case "$status_left_light $status_right_light $status_left_dark $status_right_dark" in
      *'#{battery_'*|*'#{?battery_'*)
        status_left_light=$(echo "$status_left_light" | sed -E \
          -e 's/#\{(\?)?battery_bar/#\{\1@battery_bar/g' \
          -e 's/#\{(\?)?battery_hbar/#\{\1@battery_hbar/g' \
          -e 's/#\{(\?)?battery_vbar/#\{\1@battery_vbar/g' \
          -e 's/#\{(\?)?battery_status/#\{\1@battery_status/g' \
          -e 's/#\{(\?)?battery_percentage/#\{\1@battery_percentage/g')
        status_right_light=$(echo "$status_right_light" | sed -E \
          -e 's/#\{(\?)?battery_bar/#\{\1@battery_bar/g' \
          -e 's/#\{(\?)?battery_hbar/#\{\1@battery_hbar/g' \
          -e 's/#\{(\?)?battery_vbar/#\{\1@battery_vbar/g' \
          -e 's/#\{(\?)?battery_status/#\{\1@battery_status/g' \
          -e 's/#\{(\?)?battery_percentage/#\{\1@battery_percentage/g')
        status_left_dark=$(echo "$status_left_dark" | sed -E \
          -e 's/#\{(\?)?battery_bar/#\{\1@battery_bar/g' \
          -e 's/#\{(\?)?battery_hbar/#\{\1@battery_hbar/g' \
          -e 's/#\{(\?)?battery_vbar/#\{\1@battery_vbar/g' \
          -e 's/#\{(\?)?battery_status/#\{\1@battery_status/g' \
          -e 's/#\{(\?)?battery_percentage/#\{\1@battery_percentage/g')
        status_right_dark=$(echo "$status_right_dark" | sed -E \
          -e 's/#\{(\?)?battery_bar/#\{\1@battery_bar/g' \
          -e 's/#\{(\?)?battery_hbar/#\{\1@battery_hbar/g' \
          -e 's/#\{(\?)?battery_vbar/#\{\1@battery_vbar/g' \
          -e 's/#\{(\?)?battery_status/#\{\1@battery_status/g' \
          -e 's/#\{(\?)?battery_percentage/#\{\1@battery_percentage/g')
        status_right_light="#(echo; nice ~/.tmux/tmux_32_up/theme/plugins/battery_status.sh \"$tmux_conf_battery_status_charging\" \"$tmux_conf_battery_status_discharging\")$status_right_light"
        status_right_dark="#(echo; nice ~/.tmux/tmux_32_up/theme/plugins/battery_status.sh \"$tmux_conf_battery_status_charging\" \"$tmux_conf_battery_status_discharging\")$status_right_dark"
        interval=60
        if [ $_tmux_version -ge 320 ]; then
          tmux run -b "trap '[ -n \"\$sleep_pid\" ] && kill -9 \$sleep_pid; exit 0' TERM; while [ x\"\$(tmux -S '#{socket_path}' display -p '#{l:#{pid}}')\" = x\"#{pid}\" ]; do nice ~/.tmux/tmux_32_up/theme/plugins/battery_bar.sh \"$tmux_conf_battery_bar_symbol_full\" \"$tmux_conf_battery_bar_symbol_empty\" \"$tmux_conf_battery_bar_length\" \"$tmux_conf_battery_bar_palette\" \"$tmux_conf_battery_hbar_palette\" \"$tmux_conf_battery_vbar_palette\"; sleep $interval & sleep_pid=\$!; wait \$sleep_pid; sleep_pid=; done"
        else
          case "$status_left_light $status_right_light" in
            *'#{battery_'*|*'#{?battery_'*)
              if [ $_tmux_version -ge 280 ]; then
                status_right_light="#(echo; while [ x\"\$(tmux -S '#{socket_path}' display -p '#{l:#{pid}}')\" = x\"#{pid}\" ]; do nice ~/.tmux/tmux_32_up/theme/plugins/battery_bar.sh \"$tmux_conf_battery_bar_symbol_full\" \"$tmux_conf_battery_bar_symbol_empty\" \"$tmux_conf_battery_bar_length\" \"$tmux_conf_battery_bar_palette\" \"$tmux_conf_battery_hbar_palette\" \"$tmux_conf_battery_vbar_palette\"; sleep $interval; done)$status_right_light"
              elif [ $_tmux_version -gt 240 ]; then
                status_right_light="#(echo; while :; do nice ~/.tmux/tmux_32_up/theme/plugins/battery_bar.sh \"$tmux_conf_battery_bar_symbol_full\" \"$tmux_conf_battery_bar_symbol_empty\" \"$tmux_conf_battery_bar_length\" \"$tmux_conf_battery_bar_palette\" \"$tmux_conf_battery_hbar_palette\" \"$tmux_conf_battery_vbar_palette\"; sleep $interval; done)$status_right_light"
              else
                status_right_light="#(nice ~/.tmux/tmux_32_up/theme/plugins/battery_bar.sh \"$tmux_conf_battery_bar_symbol_full\" \"$tmux_conf_battery_bar_symbol_empty\" \"$tmux_conf_battery_bar_length\" \"$tmux_conf_battery_bar_palette\" \"$tmux_conf_battery_hbar_palette\" \"$tmux_conf_battery_vbar_palette\")$status_right_light"
              fi
              ;;
          esac
          case "$status_left_dark $status_right_dark" in
            *'#{battery_'*|*'#{?battery_'*)
              if [ $_tmux_version -ge 280 ]; then
                status_right_dark="#(echo; while [ x\"\$(tmux -S '#{socket_path}' display -p '#{l:#{pid}}')\" = x\"#{pid}\" ]; do nice ~/.tmux/tmux_32_up/theme/plugins/battery_bar.sh \"$tmux_conf_battery_bar_symbol_full\" \"$tmux_conf_battery_bar_symbol_empty\" \"$tmux_conf_battery_bar_length\" \"$tmux_conf_battery_bar_palette\" \"$tmux_conf_battery_hbar_palette\" \"$tmux_conf_battery_vbar_palette\"; sleep $interval; done)$status_right_dark"
              elif [ $_tmux_version -gt 240 ]; then
                status_right_dark="#(echo; while :; do nice ~/.tmux/tmux_32_up/theme/plugins/battery_bar.sh \"$tmux_conf_battery_bar_symbol_full\" \"$tmux_conf_battery_bar_symbol_empty\" \"$tmux_conf_battery_bar_length\" \"$tmux_conf_battery_bar_palette\" \"$tmux_conf_battery_hbar_palette\" \"$tmux_conf_battery_vbar_palette\"; sleep $interval; done)$status_right_dark"
              else
                status_right_dark="#(nice ~/.tmux/tmux_32_up/theme/plugins/battery_bar.sh \"$tmux_conf_battery_bar_symbol_full\" \"$tmux_conf_battery_bar_symbol_empty\" \"$tmux_conf_battery_bar_length\" \"$tmux_conf_battery_bar_palette\" \"$tmux_conf_battery_hbar_palette\" \"$tmux_conf_battery_vbar_palette\")$status_right_dark"
              fi
              ;;
          esac
        fi
    esac
  fi

  echo "got to status_left_light" >> /Users/adamwalz/Desktop/tmux.log
  case "$status_left_light $status_right_light" in
    *'#{username}'*|*'#{hostname}'*|*'#{hostname_full}'*|*'#{username_ssh}'*|*'#{hostname_ssh}'*|*'#{hostname_full_ssh}'*)
      status_left_light=$(echo "$status_left_light" | sed \
        -e 's%#{username}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} false #D)%g' \
        -e 's%#{hostname}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false false #h #D)%g' \
        -e 's%#{hostname_full}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false true #H #D)%g' \
        -e 's%#{username_ssh}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} true #D)%g' \
        -e 's%#{hostname_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true false #h #D)%g' \
        -e 's%#{hostname_full_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true true #H #D)%g')
      status_right_light=$(echo "$status_right_light" | sed \
        -e 's%#{username}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} false #D)%g' \
        -e 's%#{hostname}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false false #h #D)%g' \
        -e 's%#{hostname_full}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false true #H #D)%g' \
        -e 's%#{username_ssh}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} true #D)%g' \
        -e 's%#{hostname_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true false #h #D)%g' \
        -e 's%#{hostname_full_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true true #H #D)%g')
      ;;
  esac

  echo "got to status_left_dark" >> /Users/adamwalz/Desktop/tmux.log
  case "$status_left_dark $status_right_dark" in
    *'#{username}'*|*'#{hostname}'*|*'#{hostname_full}'*|*'#{username_ssh}'*|*'#{hostname_ssh}'*|*'#{hostname_full_ssh}'*)
      status_left_dark=$(echo "$status_left_dark" | sed \
        -e 's%#{username}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} false #D)%g' \
        -e 's%#{hostname}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false false #h #D)%g' \
        -e 's%#{hostname_full}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false true #H #D)%g' \
        -e 's%#{username_ssh}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} true #D)%g' \
        -e 's%#{hostname_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true false #h #D)%g' \
        -e 's%#{hostname_full_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true true #H #D)%g')
      status_right_dark=$(echo "$status_right_dark" | sed \
        -e 's%#{username}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} false #D)%g' \
        -e 's%#{hostname}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false false #h #D)%g' \
        -e 's%#{hostname_full}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false true #H #D)%g' \
        -e 's%#{username_ssh}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} true #D)%g' \
        -e 's%#{hostname_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true false #h #D)%g' \
        -e 's%#{hostname_full_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true true #H #D)%g')
      ;;
  esac

  echo "got to uptime" >> /Users/adamwalz/Desktop/tmux.log
  pkillf '~/\.tmux/tmux_32_up/theme/plugins/uptime.sh'
  case "$status_left_light $status_right_light $status_left_dark $status_right_dark" in
    *'#{uptime_'*|*'#{?uptime_'*)
      status_left_light=$(echo "$status_left_light" | perl -p -e '
        ; s/#\{(\?)?uptime_y\b/#\{\1\@uptime_y/g
        ; s/#\{(\?)?uptime_d\b/#\{\1\@uptime_d/g
        ; s/\@uptime_d\b/\@uptime_dy/g if /\@uptime_y\b/
        ; s/#\{(\?)?uptime_h\b/#\{\1\@uptime_h/g
        ; s/#\{(\?)?uptime_m\b/#\{\1\@uptime_m/g
        ; s/#\{(\?)?uptime_s\b/#\{\1\@uptime_s/g')
      status_right_light=$(echo "$status_right_light" | perl -p -e '
        ; s/#\{(\?)?uptime_y\b/#\{\1\@uptime_y/g
        ; s/#\{(\?)?uptime_d\b/#\{\1\@uptime_d/g
        ; s/\@uptime_d\b/\@uptime_dy/g if /\@uptime_y\b/
        ; s/#\{(\?)?uptime_h\b/#\{\1\@uptime_h/g
        ; s/#\{(\?)?uptime_m\b/#\{\1\@uptime_m/g
        ; s/#\{(\?)?uptime_s\b/#\{\1\@uptime_s/g')
      status_left_dark=$(echo "$status_left_dark" | perl -p -e '
        ; s/#\{(\?)?uptime_y\b/#\{\1\@uptime_y/g
        ; s/#\{(\?)?uptime_d\b/#\{\1\@uptime_d/g
        ; s/\@uptime_d\b/\@uptime_dy/g if /\@uptime_y\b/
        ; s/#\{(\?)?uptime_h\b/#\{\1\@uptime_h/g
        ; s/#\{(\?)?uptime_m\b/#\{\1\@uptime_m/g
        ; s/#\{(\?)?uptime_s\b/#\{\1\@uptime_s/g')
      status_right_dark=$(echo "$status_right_dark" | perl -p -e '
        ; s/#\{(\?)?uptime_y\b/#\{\1\@uptime_y/g
        ; s/#\{(\?)?uptime_d\b/#\{\1\@uptime_d/g
        ; s/\@uptime_d\b/\@uptime_dy/g if /\@uptime_y\b/
        ; s/#\{(\?)?uptime_h\b/#\{\1\@uptime_h/g
        ; s/#\{(\?)?uptime_m\b/#\{\1\@uptime_m/g
        ; s/#\{(\?)?uptime_s\b/#\{\1\@uptime_s/g')
      interval=60
      case "$status_left_light $status_right_light $status_left_dark $status_right_dark" in
        *'#{@uptime_s}'*)
          interval=$(tmux show -gv status-interval)
          ;;
      esac
      if [ $_tmux_version -ge 320 ]; then
        tmux run -b "trap '[ -n \"\$sleep_pid\" ] && kill -9 \$sleep_pid; exit 0' TERM; while [ x\"\$(tmux -S '#{socket_path}' display -p '#{l:#{pid}}')\" = x\"#{pid}\" ]; do nice ~/.tmux/tmux_32_up/theme/plugins/uptime.sh; sleep $interval & sleep_pid=\$!; wait \$sleep_pid; sleep_pid=; done"
      else
        case "$status_left_light $status_right_light" in
          *'#{uptime_'*|*'#{?uptime_'*)
            if [ $_tmux_version -gt 280 ]; then
              status_right_light="#(echo; while [ x\"\$(tmux -S '#{socket_path}' display -p '#{l:#{pid}}')\" = x\"#{pid}\" ]; do nice ~/.tmux/tmux_32_up/theme/plugins/uptime.sh; sleep $interval; done)$status_right_light"
            elif [ $_tmux_version -gt 240 ]; then
              status_right_light="#(echo; while :; do nice ~/.tmux/tmux_32_up/theme/plugins/uptime.sh; sleep $interval; done)$status_right_light"
            else
              status_right_light="#(nice ~/.tmux/tmux_32_up/theme/plugins/uptime.sh)$status_right_light"
            fi
            ;;
        esac
        case "$status_left_dark $status_right_dark" in
          *'#{uptime_'*|*'#{?uptime_'*)
            if [ $_tmux_version -gt 280 ]; then
              status_right_dark="#(echo; while [ x\"\$(tmux -S '#{socket_path}' display -p '#{l:#{pid}}')\" = x\"#{pid}\" ]; do nice ~/.tmux/tmux_32_up/theme/plugins/uptime.sh; sleep $interval; done)$status_right_dark"
            elif [ $_tmux_version -gt 240 ]; then
              status_right_dark="#(echo; while :; do nice ~/.tmux/tmux_32_up/theme/plugins/uptime.sh; sleep $interval; done)$status_right_dark"
            else
              status_right_dark="#(nice ~/.tmux/tmux_32_up/theme/plugins/uptime.sh)$status_right_dark"
            fi
            ;;
        esac
      fi
  esac

  pkillf 'cat ~/\.tmux/tmux_32_up/tmux_32_up\.sh \| sh -s _loadavg'
  case "$status_left_light $status_right_light $status_left_dark $status_right_dark" in
    *'#{loadavg'*|*'#{?loadavg'*)
      status_left_light=$(echo "$status_left_light" | sed -E \
        -e 's/#\{(\?)?loadavg/#\{\1@loadavg/g')
      status_right_light=$(echo "$status_right_light" | sed -E \
        -e 's/#\{(\?)?loadavg/#\{\1@loadavg/g')
      status_left_dark=$(echo "$status_left_dark" | sed -E \
        -e 's/#\{(\?)?loadavg/#\{\1@loadavg/g')
      status_right_dark=$(echo "$status_right_dark" | sed -E \
        -e 's/#\{(\?)?loadavg/#\{\1@loadavg/g')
      interval=$(tmux show -gv status-interval)

      if [ $_tmux_version -ge 320 ]; then
        tmux run -b "trap '[ -n \"\$sleep_pid\" ] && kill -9 \$sleep_pid; exit 0' TERM; while [ x\"\$(tmux -S '#{socket_path}' display -p '#{l:#{pid}}')\" = x\"#{pid}\" ]; do nice ~/.tmux/tmux_32_up/theme/plugins/loadavg.sh; sleep $interval & sleep_pid=\$!; wait \$sleep_pid; sleep_pid=; done"
      else
        case "$status_left_light $status_right_light" in
          *'#{loadavg'*|*'#{?loadavg'*)
            if [ $_tmux_version -gt 280 ]; then
              status_right_light="#(echo; while [ x\"\$(tmux -S '#{socket_path}' display -p '#{l:#{pid}}')\" = x\"#{pid}\" ]; do nice ~/.tmux/tmux_32_up/theme/plugins/loadavg.sh; sleep $interval; done)$status_right_light"
            elif [ $_tmux_version -gt 240 ]; then
              status_right_light="#(echo; while :; do nice ~/.tmux/tmux_32_up/theme/plugins/loadavg.sh; sleep $interval; done)$status_right_light"
            else
              status_right_light="#(nice ~/.tmux/tmux_32_up/theme/plugins/loadavg.sh)$status_right_light"
            fi
            ;;
        esac

        case "$status_left_dark $status_right_dark" in
          *'#{loadavg'*|*'#{?loadavg'*)
            if [ $_tmux_version -gt 280 ]; then
              status_right_dark="#(echo; while [ x\"\$(tmux -S '#{socket_path}' display -p '#{l:#{pid}}')\" = x\"#{pid}\" ]; do nice ~/.tmux/tmux_32_up/theme/plugins/loadavg.sh; sleep $interval; done)$status_right_dark"
            elif [ $_tmux_version -gt 240 ]; then
              status_right_dark="#(echo; while :; do nice ~/.tmux/tmux_32_up/theme/plugins/loadavg.sh; sleep $interval; done)$status_right_dark"
            else
              status_right_dark="#(nice ~/.tmux/tmux_32_up/theme/plugins/loadavg.sh)$status_right_dark"
            fi
            ;;
        esac
      fi
      ;;
  esac

  echo "got to clock" >> /Users/adamwalz/Desktop/tmux.log
  # -- clock -------------------------------------------------------------

  tmux_conf_theme_clock_color_light=${tmux_conf_theme_clock_color_light:-$tmux_conf_theme_color_clock_color_light}
  tmux_conf_theme_clock_color_dark=${tmux_conf_theme_clock_color_dark:-$tmux_conf_theme_color_clock_color_dark}
  tmux_conf_theme_clock_style=${tmux_conf_theme_clock_style:-24}

  echo "got to custom variables" >> /Users/adamwalz/Desktop/tmux.log
  # -- custom variables ---------------------------------------------------

  if [ -f ~/.tmux/tmux_32_up/tmux_32_up.conf.local ] && [ x"$(cat ~/.tmux/tmux_32_up/tmux_32_up.sh.local | sh 2>/dev/null -s printf probe)" = x"probe" ]; then
    replacements=$(perl -n -e 'print if s!^#\s+([^_][^()\s]+)\s*\(\)\s*{\s*\n!s%#\\\{\1((?:\\s+(?:[^\{\}]+?|#\\{(?:[^\{\}]+?)\}))*)\\\}%#(cat ~/.tmux/tmux_32_up/tmux_32_up.sh.local | sh -s \1\\1)%g; !p' < ~/.tmux/tmux_32_up/tmux_32_up.conf.local)
    status_left_light=$(echo "$status_left_light" | perl -p -e "$replacements" || echo "$status_left_light")
    status_left_dark=$(echo "$status_left_dark" | perl -p -e "$replacements" || echo "$status_left_dark")
    status_right_light=$(echo "$status_right_light" | perl -p -e "$replacements" || echo "$status_right_light")
    status_right_dark=$(echo "$status_right_dark" | perl -p -e "$replacements" || echo "$status_right_dark")
  fi

  # -----------------------------------------------------------------------

  if is_dark_mode_enabled; then
    echo "dark mode enabled" >> /Users/adamwalz/Desktop/tmux.log
    ############ Dark Mode theme profile ############
    tmux setw -g window-style "$window_style_dark" \; setw -g window-active-style "$window_active_style_dark" \;\
         setw -g pane-border-style "fg=$tmux_conf_theme_pane_border_fg_dark,bg=$tmux_conf_theme_pane_border_bg_dark" \; set -g pane-active-border-style "fg=$tmux_conf_theme_pane_active_border_fg_dark,bg=$tmux_conf_theme_pane_active_border_bg_dark" \;\
         set -g display-panes-colour "$tmux_conf_theme_pane_indicator_dark" \; set -g display-panes-active-colour "$tmux_conf_theme_pane_active_indicator_dark" \;\
         set -g message-style "fg=$tmux_conf_theme_message_fg_dark,bg=$tmux_conf_theme_message_bg_dark,$tmux_conf_theme_message_attr" \;\
         set -g message-command-style "fg=$tmux_conf_theme_message_command_fg_dark,bg=$tmux_conf_theme_message_command_bg_dark,$tmux_conf_theme_message_command_attr" \;\
         setw -g mode-style "fg=$tmux_conf_theme_mode_fg_dark,bg=$tmux_conf_theme_mode_bg_dark,$tmux_conf_theme_mode_attr" \;\
         set -g status-style "fg=$tmux_conf_theme_status_fg_dark,bg=$tmux_conf_theme_status_bg_dark,$tmux_conf_theme_status_attr"        \;\
         set -g status-left-style "fg=$tmux_conf_theme_status_fg_dark,bg=$tmux_conf_theme_status_bg_dark,$tmux_conf_theme_status_attr"   \;\
         set -g status-right-style "fg=$tmux_conf_theme_status_fg_dark,bg=$tmux_conf_theme_status_bg_dark,$tmux_conf_theme_status_attr" \;\
         set -g set-titles-string "$(decode_unicode_escapes "$tmux_conf_theme_terminal_title")" \;\
         setw -g window-status-style "fg=$tmux_conf_theme_window_status_fg_dark,bg=$tmux_conf_theme_window_status_bg_dark,$tmux_conf_theme_window_status_attr" \;\
         setw -g window-status-format "$(decode_unicode_escapes "$tmux_conf_theme_window_status_format_dark")" \;\
         setw -g window-status-current-style "fg=$tmux_conf_theme_window_status_current_fg_dark,bg=$tmux_conf_theme_window_status_current_bg_dark,$tmux_conf_theme_window_status_current_attr" \;\
         setw -g window-status-current-format "$(decode_unicode_escapes "$tmux_conf_theme_window_status_current_format_dark")" \;\
         setw -g window-status-activity-style "fg=$tmux_conf_theme_window_status_activity_fg_dark,bg=$tmux_conf_theme_window_status_activity_bg_dark,$tmux_conf_theme_window_status_activity_attr" \;\
         setw -g window-status-bell-style "fg=$tmux_conf_theme_window_status_bell_fg_dark,bg=$tmux_conf_theme_window_status_bell_bg_dark,$tmux_conf_theme_window_status_bell_attr" \;\
         setw -g window-status-last-style "fg=$tmux_conf_theme_window_status_last_fg_dark,bg=$tmux_conf_theme_window_status_last_bg_dark,$tmux_conf_theme_window_status_last_attr" \;\
         setw -g window-status-separator "$window_status_separator" \;\
         set -g status-left-length 1000 \; set -g status-left "$(decode_unicode_escapes "$status_left_dark")" \;\
         set -g status-right-length 1000 \; set -g status-right "$(decode_unicode_escapes "$status_right_dark")" \;\
         setw -g clock-mode-colour "$tmux_conf_theme_clock_color_dark" \;\
         setw -g clock-mode-style "$tmux_conf_theme_clock_style"
  else
    echo "dark mode disabled" >> /Users/adamwalz/Desktop/tmux.log
    ############ Light Mode theme profile ############
    tmux setw -g window-style "$window_style_light" \; setw -g window-active-style "$window_active_style_light" \;\
         setw -g pane-border-style "fg=$tmux_conf_theme_pane_border_fg_light,bg=$tmux_conf_theme_pane_border_bg_light" \; set -g pane-active-border-style "fg=$tmux_conf_theme_pane_active_border_fg_light,bg=$tmux_conf_theme_pane_active_border_bg_light" \;\
         set -g display-panes-colour "$tmux_conf_theme_pane_indicator_light" \; set -g display-panes-active-colour "$tmux_conf_theme_pane_active_indicator_light" \;\
         set -g message-style "fg=$tmux_conf_theme_message_fg_light,bg=$tmux_conf_theme_message_bg_light,$tmux_conf_theme_message_attr" \;\
         set -g message-command-style "fg=$tmux_conf_theme_message_command_fg_light,bg=$tmux_conf_theme_message_command_bg_light,$tmux_conf_theme_message_command_attr" \;\
         setw -g mode-style "fg=$tmux_conf_theme_mode_fg_light,bg=$tmux_conf_theme_mode_bg_light,$tmux_conf_theme_mode_attr" \;\
         set -g status-style "fg=$tmux_conf_theme_status_fg_light,bg=$tmux_conf_theme_status_bg_light,$tmux_conf_theme_status_attr"        \;\
         set -g status-left-style "fg=$tmux_conf_theme_status_fg_light,bg=$tmux_conf_theme_status_bg_light,$tmux_conf_theme_status_attr"   \;\
         set -g status-right-style "fg=$tmux_conf_theme_status_fg_light,bg=$tmux_conf_theme_status_bg_light,$tmux_conf_theme_status_attr" \;\
         set -g set-titles-string "$(decode_unicode_escapes "$tmux_conf_theme_terminal_title")" \;\
         setw -g window-status-style "fg=$tmux_conf_theme_window_status_fg_light,bg=$tmux_conf_theme_window_status_bg_light,$tmux_conf_theme_window_status_attr" \;\
         setw -g window-status-format "$(decode_unicode_escapes "$tmux_conf_theme_window_status_format_light")" \;\
         setw -g window-status-current-style "fg=$tmux_conf_theme_window_status_current_fg_light,bg=$tmux_conf_theme_window_status_current_bg_light,$tmux_conf_theme_window_status_current_attr" \;\
         setw -g window-status-current-format "$(decode_unicode_escapes "$tmux_conf_theme_window_status_current_format_light")" \;\
         setw -g window-status-activity-style "fg=$tmux_conf_theme_window_status_activity_fg_light,bg=$tmux_conf_theme_window_status_activity_bg_light,$tmux_conf_theme_window_status_activity_attr" \;\
         setw -g window-status-bell-style "fg=$tmux_conf_theme_window_status_bell_fg_light,bg=$tmux_conf_theme_window_status_bell_bg_light,$tmux_conf_theme_window_status_bell_attr" \;\
         setw -g window-status-last-style "fg=$tmux_conf_theme_window_status_last_fg_light,bg=$tmux_conf_theme_window_status_last_bg_light,$tmux_conf_theme_window_status_last_attr" \;\
         setw -g window-status-separator "$window_status_separator" \;\
         set -g status-left-length 1000 \; set -g status-left "$(decode_unicode_escapes "$status_left_light")" \;\
         set -g status-right-length 1000 \; set -g status-right "$(decode_unicode_escapes "$status_right_light")" \;\
         setw -g clock-mode-colour "$tmux_conf_theme_clock_color_light" \;\
         setw -g clock-mode-style "$tmux_conf_theme_clock_style"
  fi

}