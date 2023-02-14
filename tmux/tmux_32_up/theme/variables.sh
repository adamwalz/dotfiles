# -- default theme -----------------------------------------------------

tmux_conf_theme_color_message_fg_light=${tmux_conf_theme_color_message_fg_light:-#080808}
tmux_conf_theme_color_message_command_bg_light=${tmux_conf_theme_color_message_command_bg_light:-#080808}
tmux_conf_theme_color_mode_fg_light=${tmux_conf_theme_color_mode_fg_light:-#080808}
tmux_conf_theme_color_status_bg_light=${tmux_conf_theme_color_status_bg_light:-#080808}
tmux_conf_theme_color_window_status_bg_light=${tmux_conf_theme_color_window_status_bg_light:-#080808}
tmux_conf_theme_color_window_status_current_fg_light=${tmux_conf_theme_color_window_status_current_fg_light:-#080808}
tmux_conf_theme_color_focused_pane_bg_light=${tmux_conf_theme_color_focused_pane_bg_light:-#303030}
tmux_conf_theme_color_pane_border_light=${tmux_conf_theme_color_pane_border_light:-#303030}
tmux_conf_theme_color_window_status_last_bg_light=${tmux_conf_theme_color_window_status_last_bg_light:-#303030}
tmux_conf_theme_color_pane_indicator_light=${tmux_conf_theme_color_pane_indicator_light:-#8a8a8a}
tmux_conf_theme_color_status_fg_light=${tmux_conf_theme_color_status_fg_light:-#8a8a8a}
tmux_conf_theme_color_window_status_fg_light=${tmux_conf_theme_color_window_status_fg_light:-#8a8a8a}
tmux_conf_theme_color_pane_active_border_light=${tmux_conf_theme_color_pane_active_border_light:-#00afff}
tmux_conf_theme_color_pane_active_indicator_light=${tmux_conf_theme_color_pane_active_indicator_light:-#00afff}
tmux_conf_theme_color_window_status_current_bg_light=${tmux_conf_theme_color_window_status_current_light:-#00afff}
tmux_conf_theme_color_window_status_last_fg_light=${tmux_conf_theme_color_window_status_last_fg_light:-#00afff}
tmux_conf_theme_color_clock_color_light=${tmux_conf_theme_color_clock_color_light:-#00afff}
tmux_conf_theme_color_message_bg_light=${tmux_conf_theme_color_message_bg_light:-#ffff00}
tmux_conf_theme_color_message_command_fg_light=${tmux_conf_theme_color_message_command_fg_light:-#ffff00}
tmux_conf_theme_color_mode_bg_light=${tmux_conf_theme_color_mode_bg_light:-#ffff00}
tmux_conf_theme_color_window_status_bell_fg_light=${tmux_conf_theme_color_window_status_bell_fg_light:-#ffff00}

tmux_conf_theme_color_message_fg_dark=${tmux_conf_theme_color_message_fg_dark:-#080808}
tmux_conf_theme_color_message_command_bg_dark=${tmux_conf_theme_color_message_command_bg_dark:-#080808}
tmux_conf_theme_color_mode_fg_dark=${tmux_conf_theme_color_mode_fg_dark:-#080808}
tmux_conf_theme_color_status_bg_dark=${tmux_conf_theme_color_status_bg_dark:-#080808}
tmux_conf_theme_color_window_status_bg_dark=${tmux_conf_theme_color_window_status_bg_dark:-#080808}
tmux_conf_theme_color_window_status_current_fg_dark=${tmux_conf_theme_color_window_status_current_fg_dark:-#080808}
tmux_conf_theme_color_focused_pane_bg_dark=${tmux_conf_theme_color_focused_pane_bg_dark:-#303030}
tmux_conf_theme_color_pane_border_dark=${tmux_conf_theme_color_pane_border_dark:-#303030}
tmux_conf_theme_color_window_status_last_bg_dark=${tmux_conf_theme_color_window_status_last_bg_dark:-#303030}
tmux_conf_theme_color_pane_indicator_dark=${tmux_conf_theme_color_pane_indicator_dark:-#8a8a8a}
tmux_conf_theme_color_status_fg_dark=${tmux_conf_theme_color_status_fg_dark:-#8a8a8a}
tmux_conf_theme_color_window_status_fg_dark=${tmux_conf_theme_color_window_status_fg_dark:-#8a8a8a}
tmux_conf_theme_color_pane_active_border_dark=${tmux_conf_theme_color_pane_active_border_dark:-#00afff}
tmux_conf_theme_color_pane_active_indicator_dark=${tmux_conf_theme_color_pane_active_indicator_dark:-#00afff}
tmux_conf_theme_color_window_status_current_bg_dark=${tmux_conf_theme_color_window_status_current_dark:-#00afff}
tmux_conf_theme_color_window_status_last_fg_dark=${tmux_conf_theme_color_window_status_last_fg_dark:-#00afff}
tmux_conf_theme_color_clock_color_dark=${tmux_conf_theme_color_clock_color_dark:-#00afff}
tmux_conf_theme_color_message_bg_dark=${tmux_conf_theme_color_message_bg_dark:-#ffff00}
tmux_conf_theme_color_message_command_fg_dark=${tmux_conf_theme_color_message_command_fg_dark:-#ffff00}
tmux_conf_theme_color_mode_bg_dark=${tmux_conf_theme_color_mode_bg_dark:-#ffff00}
tmux_conf_theme_color_window_status_bell_fg_dark=${tmux_conf_theme_color_window_status_bell_fg_dark:-#ffff00}


# -- panes -------------------------------------------------------------

tmux_conf_theme_window_fg_light=${tmux_conf_theme_window_fg_light:-default}
tmux_conf_theme_window_fg_dark=${tmux_conf_theme_window_fg_dark:-default}
tmux_conf_theme_window_bg_light=${tmux_conf_theme_window_bg_light:-default}
tmux_conf_theme_window_bg_dark=${tmux_conf_theme_window_bg_dark:-default}
tmux_conf_theme_highlight_focused_pane=${tmux_conf_theme_highlight_focused_pane:-false}
tmux_conf_theme_focused_pane_fg_light=${tmux_conf_theme_focused_pane_fg_light:-default}
tmux_conf_theme_focused_pane_fg_dark=${tmux_conf_theme_focused_pane_fg_dark:-default}
tmux_conf_theme_focused_pane_bg_light=${tmux_conf_theme_focused_pane_bg:-$tmux_conf_theme_color_focused_pane_bg_light}
tmux_conf_theme_focused_pane_bg_dark=${tmux_conf_theme_focused_pane_bg:-$tmux_conf_theme_color_focused_pane_bg_dark}

window_style_light="fg=$tmux_conf_theme_window_fg_light,bg=$tmux_conf_theme_window_bg_light"
window_style_dark="fg=$tmux_conf_theme_window_fg_dark,bg=$tmux_conf_theme_window_bg_dark"
if is_true "$tmux_conf_theme_highlight_focused_pane"; then
  window_active_style_light="fg=$tmux_conf_theme_focused_pane_fg_light,bg=$tmux_conf_theme_focused_pane_bg_light"
  window_active_style_dark="fg=$tmux_conf_theme_focused_pane_fg_dark,bg=$tmux_conf_theme_focused_pane_bg_dark"
else
  window_active_style_light="default"
  window_active_style_dark="default"
fi

tmux_conf_theme_pane_border_style=${tmux_conf_theme_pane_border_style:-thin}
tmux_conf_theme_pane_border_light=${tmux_conf_theme_pane_border_light:-$tmux_conf_theme_color_pane_border_light}
tmux_conf_theme_pane_border_dark=${tmux_conf_theme_pane_border_dark:-$tmux_conf_theme_color_pane_border_dark}
tmux_conf_theme_pane_active_border_light=${tmux_conf_theme_pane_active_border_light:-$tmux_conf_theme_color_pane_active_border_light}
tmux_conf_theme_pane_active_border_dark=${tmux_conf_theme_pane_active_border_dark:-$tmux_conf_theme_color_pane_active_border_dark}
tmux_conf_theme_pane_border_fg_light=${tmux_conf_theme_pane_border_fg_light:-$tmux_conf_theme_pane_border_light}
tmux_conf_theme_pane_border_fg_dark=${tmux_conf_theme_pane_border_fg_dark:-$tmux_conf_theme_pane_border_dark}
tmux_conf_theme_pane_active_border_fg_light=${tmux_conf_theme_pane_active_border_fg_light:-$tmux_conf_theme_pane_active_border_light}
tmux_conf_theme_pane_active_border_fg_dark=${tmux_conf_theme_pane_active_border_fg_dark:-$tmux_conf_theme_pane_active_border_dark}
case "$tmux_conf_theme_pane_border_style" in
  fat)
    tmux_conf_theme_pane_border_bg_light=${tmux_conf_theme_pane_border_bg_light:-$tmux_conf_theme_pane_border_fg_light}
    tmux_conf_theme_pane_border_bg_dark=${tmux_conf_theme_pane_border_bg_dark:-$tmux_conf_theme_pane_border_fg_dark}
    tmux_conf_theme_pane_active_border_bg_light=${tmux_conf_theme_pane_active_border_bg_light:-$tmux_conf_theme_pane_active_border_fg_light}
    tmux_conf_theme_pane_active_border_bg_dark=${tmux_conf_theme_pane_active_border_bg_dark:-$tmux_conf_theme_pane_active_border_fg_dark}
    ;;
  thin|*)
    tmux_conf_theme_pane_border_bg_light=${tmux_conf_theme_pane_border_bg_light:-default}
    tmux_conf_theme_pane_border_bg_dark=${tmux_conf_theme_pane_border_bg_dark:-default}
    tmux_conf_theme_pane_active_border_bg_light=${tmux_conf_theme_pane_active_border_bg_light:-default}
    tmux_conf_theme_pane_active_border_bg_dark=${tmux_conf_theme_pane_active_border_bg_dark:-default}
    ;;
esac

tmux_conf_theme_pane_indicator_light=${tmux_conf_theme_pane_indicator_light:-$tmux_conf_theme_color_pane_indicator_light}
tmux_conf_theme_pane_indicator_dark=${tmux_conf_theme_pane_indicator_dark:-$tmux_conf_theme_color_pane_indicator_dark}
tmux_conf_theme_pane_active_indicator_light=${tmux_conf_theme_pane_active_indicator_light:-$tmux_conf_theme_color_pane_active_indicator_light}
tmux_conf_theme_pane_active_indicator_dark=${tmux_conf_theme_pane_active_indicator_dark:-$tmux_conf_theme_color_pane_active_indicator_dark}

# -- status line -------------------------------------------------------

tmux_conf_theme_left_separator_main=$(decode_unicode_escapes "${tmux_conf_theme_left_separator_main-}")
tmux_conf_theme_left_separator_sub=$(decode_unicode_escapes "${tmux_conf_theme_left_separator_sub-|}")
tmux_conf_theme_right_separator_main=$(decode_unicode_escapes "${tmux_conf_theme_right_separator_main-}")
tmux_conf_theme_right_separator_sub=$(decode_unicode_escapes "${tmux_conf_theme_right_separator_sub-|}")

tmux_conf_theme_message_fg_light=${tmux_conf_theme_message_fg_light:-$tmux_conf_theme_color_message_fg_light}
tmux_conf_theme_message_fg_dark=${tmux_conf_theme_message_fg_dark:-$tmux_conf_theme_color_message_fg_dark}
tmux_conf_theme_message_bg_light=${tmux_conf_theme_message_bg_light:-$tmux_conf_theme_color_message_bg_light}
tmux_conf_theme_message_bg_dark=${tmux_conf_theme_message_bg_dark:-$tmux_conf_theme_color_message_bg_dark}
tmux_conf_theme_message_attr=${tmux_conf_theme_message_attr:-bold}

tmux_conf_theme_message_command_fg_light=${tmux_conf_theme_message_command_fg_light:-$tmux_conf_theme_color_message_command_fg_light}
tmux_conf_theme_message_command_fg_dark=${tmux_conf_theme_message_command_fg_dark:-$tmux_conf_theme_color_message_command_fg_dark}
tmux_conf_theme_message_command_bg_light=${tmux_conf_theme_message_command_bg_light:-$tmux_conf_theme_color_message_command_bg_light}
tmux_conf_theme_message_command_bg_dark=${tmux_conf_theme_message_command_bg_dark:-$tmux_conf_theme_color_message_command_bg_dark}
tmux_conf_theme_message_command_attr=${tmux_conf_theme_message_command_attr:-bold}

tmux_conf_theme_mode_fg_light=${tmux_conf_theme_mode_fg_light:-$tmux_conf_theme_color_mode_fg_light}
tmux_conf_theme_mode_fg_dark=${tmux_conf_theme_mode_fg_dark:-$tmux_conf_theme_color_mode_fg_dark}
tmux_conf_theme_mode_bg_light=${tmux_conf_theme_mode_bg_light:-$tmux_conf_theme_color_mode_bg_light}
tmux_conf_theme_mode_bg_dark=${tmux_conf_theme_mode_bg_dark:-$tmux_conf_theme_color_mode_bg_dark}
tmux_conf_theme_mode_attr=${tmux_conf_theme_mode_attr:-bold}

tmux_conf_theme_status_fg_light=${tmux_conf_theme_status_fg_light:-$tmux_conf_theme_color_status_fg_light}
tmux_conf_theme_status_fg_dark=${tmux_conf_theme_status_fg_dark:-$tmux_conf_theme_color_status_fg_dark}
tmux_conf_theme_status_bg_light=${tmux_conf_theme_status_bg_light:-$tmux_conf_theme_color_status_bg_light}
tmux_conf_theme_status_bg_dark=${tmux_conf_theme_status_bg_dark:-$tmux_conf_theme_color_status_bg_dark}
tmux_conf_theme_status_attr=${tmux_conf_theme_status_attr:-none}

tmux_conf_theme_terminal_title=${tmux_conf_theme_terminal_title:-#h ❐ #S ● #I #W}

tmux_conf_theme_terminal_title=$(echo "$tmux_conf_theme_terminal_title" | sed \
  -e 's%#{circled_window_index}%#(~/.tmux/tmux_32_up/helpers/circled.sh #I)%g' \
  -e 's%#{circled_session_name}%#(~/.tmux/tmux_32_up/helpers/circled.sh #S)%g' \
  -e 's%#{username}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} false #D)%g' \
  -e 's%#{hostname}%#(~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false false #h #D)%g' \
  -e 's%#{hostname_full}%#(~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false true #H #D)%g' \
  -e 's%#{username_ssh}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} true #D)%g' \
  -e 's%#{hostname_ssh}%#(~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true false #h #D)%g' \
  -e 's%#{hostname_full_ssh}%#(~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true true #H #D)%g')

tmux_conf_theme_window_status_fg_light=${tmux_conf_theme_window_status_fg_light:-$tmux_conf_theme_color_window_status_fg_light}
tmux_conf_theme_window_status_fg_dark=${tmux_conf_theme_window_status_fg_dark:-$tmux_conf_theme_color_window_status_fg_dark}
tmux_conf_theme_window_status_bg_light=${tmux_conf_theme_window_status_bg_light:-$tmux_conf_theme_color_window_status_bg_light}
tmux_conf_theme_window_status_bg_dark=${tmux_conf_theme_window_status_bg_dark:-$tmux_conf_theme_color_window_status_bg_dark}
tmux_conf_theme_window_status_attr=${tmux_conf_theme_window_status_attr:-none}
tmux_conf_theme_window_status_format_light=${tmux_conf_theme_window_status_format_light:-#I #W}
tmux_conf_theme_window_status_format_dark=${tmux_conf_theme_window_status_format_dark:-#I #W}

tmux_conf_theme_window_status_current_fg_light=${tmux_conf_theme_window_status_current_fg_light:-$tmux_conf_theme_color_window_status_current_fg_light}
tmux_conf_theme_window_status_current_fg_dark=${tmux_conf_theme_window_status_current_fg_dark:-$tmux_conf_theme_color_window_status_current_fg_dark}
tmux_conf_theme_window_status_current_bg_light=${tmux_conf_theme_window_status_current_bg_light:-$tmux_conf_theme_color_window_status_current_bg_light}
tmux_conf_theme_window_status_current_bg_dark=${tmux_conf_theme_window_status_current_bg_dark:-$tmux_conf_theme_color_window_status_current_bg_dark}
tmux_conf_theme_window_status_current_attr=${tmux_conf_theme_window_status_current_attr:-bold}
tmux_conf_theme_window_status_current_format_light=${tmux_conf_theme_window_status_current_format_light:-#I #W}
tmux_conf_theme_window_status_current_format_dark=${tmux_conf_theme_window_status_current_format_dark:-#I #W}

tmux_conf_theme_window_status_activity_fg_light=${tmux_conf_theme_window_status_activity_fg_light:-default}
tmux_conf_theme_window_status_activity_fg_dark=${tmux_conf_theme_window_status_activity_fg_dark:-default}
tmux_conf_theme_window_status_activity_bg_light=${tmux_conf_theme_window_status_activity_bg_light:-default}
tmux_conf_theme_window_status_activity_bg_dark=${tmux_conf_theme_window_status_activity_bg_dark:-default}
tmux_conf_theme_window_status_activity_attr=${tmux_conf_theme_window_status_activity_attr:-underscore}

tmux_conf_theme_window_status_bell_fg_light=${tmux_conf_theme_window_status_bell_fg_light:-$tmux_conf_theme_color_window_status_bell_fg_light}
tmux_conf_theme_window_status_bell_fg_dark=${tmux_conf_theme_window_status_bell_fg_dark:-$tmux_conf_theme_color_window_status_bell_fg_dark}
tmux_conf_theme_window_status_bell_bg_light=${tmux_conf_theme_window_status_bell_bg_light:-default}
tmux_conf_theme_window_status_bell_bg_dark=${tmux_conf_theme_window_status_bell_bg_dark:-default}
tmux_conf_theme_window_status_bell_attr=${tmux_conf_theme_window_status_bell_attr:-blink,bold}

tmux_conf_theme_window_status_last_fg_light=${tmux_conf_theme_window_status_last_fg_light:-$tmux_conf_theme_color_window_status_last_fg_light}
tmux_conf_theme_window_status_last_fg_dark=${tmux_conf_theme_window_status_last_fg_dark:-$tmux_conf_theme_color_window_status_last_fg_dark}
tmux_conf_theme_window_status_last_bg_light=${tmux_conf_theme_window_status_last_bg_light:-default}
tmux_conf_theme_window_status_last_bg_dark=${tmux_conf_theme_window_status_last_bg_dark:-default}
tmux_conf_theme_window_status_last_attr=${tmux_conf_theme_window_status_last_attr:-none}

if [ x"$tmux_conf_theme_window_status_bg_light" = x"$tmux_conf_theme_status_bg_light" ] || [ x"$tmux_conf_theme_window_status_bg_light" = x"default" ] [ x"$tmux_conf_theme_window_status_bg_dark" = x"$tmux_conf_theme_status_bg_dark" ] || [ x"$tmux_conf_theme_window_status_bg_dark" = x"default" ]; then
  spacer=''
  spacer_current=' '
else
  spacer=' '
  spacer_current=' '
fi
if [ x"$tmux_conf_theme_window_status_last_bg_light" = x"$tmux_conf_theme_status_bg_light" ] || [ x"$tmux_conf_theme_window_status_last_bg_light" = x"default" ] || [ x"$tmux_conf_theme_window_status_last_bg_dark" = x"$tmux_conf_theme_status_bg_dark" ] || [ x"$tmux_conf_theme_window_status_last_bg_dark" = x"default" ]; then
  spacer_last=''
else
  spacer_last=' '
fi
if [ x"$tmux_conf_theme_window_status_activity_bg_light" = x"$tmux_conf_theme_status_bg_light" ] || [ x"$tmux_conf_theme_window_status_activity_bg_light" = x"default" ] || [ x"$tmux_conf_theme_window_status_activity_bg_dark" = x"$tmux_conf_theme_status_bg_dark" ] || [ x"$tmux_conf_theme_window_status_activity_bg_dark" = x"default" ]; then
  spacer_activity=''
  spacer_last_activity="$spacer_last"
else
  spacer_activity=' '
  spacer_last_activity=' '
fi
if [ x"$tmux_conf_theme_window_status_bell_bg_light" = x"$tmux_conf_theme_status_bg_light" ] || [ x"$tmux_conf_theme_window_status_bell_bg_light" = x"default" ] || [ x"$tmux_conf_theme_window_status_bell_bg_dark" = x"$tmux_conf_theme_status_bg_dark" ] || [ x"$tmux_conf_theme_window_status_bell_bg_dark" = x"default" ]; then
  spacer_bell=''
  spacer_last_bell="$spacer_last"
  spacer_activity_bell="$spacer_activity"
  spacer_last_activity_bell="$spacer_last_activity"
else
  spacer_bell=' '
  spacer_last_bell=' '
  spacer_activity_bell=' '
  spacer_last_activity_bell=' '
fi
spacer="#{?window_last_flag,#{?window_activity_flag,#{?window_bell_flag,$spacer_last_activity_bell,$spacer_last_activity},#{?window_bell_flag,$spacer_last_bell,$spacer_last}},#{?window_activity_flag,#{?window_bell_flag,$spacer_activity_bell,$spacer_activity},#{?window_bell_flag,$spacer_bell,$spacer}}}"
if [ x"$(tmux show -g -v status-justify)" = x"right" ]; then
  if [ -z "$tmux_conf_theme_right_separator_main" ]; then
    window_status_separator=' '
  else
    window_status_separator=''
  fi

  tmux_conf_theme_window_status_format_light="#[fg=$tmux_conf_theme_window_status_bg_light,bg=$tmux_conf_theme_status_bg_light,none]#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_bg_light" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_bg_light" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_bg_light" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}$tmux_conf_theme_right_separator_main#[fg=$tmux_conf_theme_window_status_fg_light,bg=$tmux_conf_theme_window_status_bg_light,$tmux_conf_theme_window_status_attr]#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_fg_light" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_bg_light" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_fg_light" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_bg_light" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_fg_light" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_bg_light" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}$spacer$(printf "$tmux_conf_theme_window_status_last_attr" | perl -n -e 'print "#{?window_last_flag,#[none],}" if !/default/ ; s/([a-z]+),?/#{?window_last_flag,#[\1],}/g; print if !/default/')$(printf "$tmux_conf_theme_window_status_activity_attr" | perl -n -e 'print "#{?window_activity_flag?,#[none],}" if !/default/ ; s/([a-z]+),?/#{?window_activity_flag,#[\1],}/g; print if !/default/')$(printf "$tmux_conf_theme_window_status_bell_attr" | perl -n -e 'print "#{?window_bell_flag,#[none],}" if !/default/ ; s/([a-z]+),?/#{?window_bell_flag,#[\1],}/g; print if !/default/')$tmux_conf_theme_window_status_format_light#[none]$spacer#[fg=$tmux_conf_theme_status_bg_light,bg=$tmux_conf_theme_window_status_bg_light]#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_bg_light" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_bg_light" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_bg_light" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#[none]$tmux_conf_theme_right_separator_main"

  tmux_conf_theme_window_status_format_dark="#[fg=$tmux_conf_theme_window_status_bg_dark,bg=$tmux_conf_theme_status_bg_dark,none]#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_bg_dark" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_bg_dark" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_bg_dark" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}$tmux_conf_theme_right_separator_main#[fg=$tmux_conf_theme_window_status_fg_dark,bg=$tmux_conf_theme_window_status_bg_dark,$tmux_conf_theme_window_status_attr]#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_fg_dark" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_bg_dark" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_fg_dark" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_bg_dark" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_fg_dark" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_bg_dark" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}$spacer$(printf "$tmux_conf_theme_window_status_last_attr" | perl -n -e 'print "#{?window_last_flag,#[none],}" if !/default/ ; s/([a-z]+),?/#{?window_last_flag,#[\1],}/g; print if !/default/')$(printf "$tmux_conf_theme_window_status_activity_attr" | perl -n -e 'print "#{?window_activity_flag?,#[none],}" if !/default/ ; s/([a-z]+),?/#{?window_activity_flag,#[\1],}/g; print if !/default/')$(printf "$tmux_conf_theme_window_status_bell_attr" | perl -n -e 'print "#{?window_bell_flag,#[none],}" if !/default/ ; s/([a-z]+),?/#{?window_bell_flag,#[\1],}/g; print if !/default/')$tmux_conf_theme_window_status_format_dark#[none]$spacer#[fg=$tmux_conf_theme_status_bg_dark,bg=$tmux_conf_theme_window_status_bg_dark]#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_bg_dark" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_bg_dark" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_bg_dark" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#[none]$tmux_conf_theme_right_separator_main"

  tmux_conf_theme_window_status_current_format_light="#[fg=$tmux_conf_theme_window_status_current_bg_light,bg=$tmux_conf_theme_status_bg_light,none]$tmux_conf_theme_right_separator_main#[fg=$tmux_conf_theme_window_status_current_fg_light,bg=$tmux_conf_theme_window_status_current_bg_light,$tmux_conf_theme_window_status_current_attr]$spacer_current$tmux_conf_theme_window_status_current_format_light$spacer_current#[fg=$tmux_conf_theme_status_bg_light,bg=$tmux_conf_theme_window_status_current_bg_light,none]$tmux_conf_theme_right_separator_main"
  tmux_conf_theme_window_status_current_format_dark="#[fg=$tmux_conf_theme_window_status_current_bg_dark,bg=$tmux_conf_theme_status_bg_dark,none]$tmux_conf_theme_right_separator_main#[fg=$tmux_conf_theme_window_status_current_fg_dark,bg=$tmux_conf_theme_window_status_current_bg_dark,$tmux_conf_theme_window_status_current_attr]$spacer_current$tmux_conf_theme_window_status_current_format_dark$spacer_current#[fg=$tmux_conf_theme_status_bg_dark,bg=$tmux_conf_theme_window_status_current_bg_dark,none]$tmux_conf_theme_right_separator_main"
else
  if [ -z "$tmux_conf_theme_left_separator_main" ]; then
    window_status_separator=' '
  else
    window_status_separator=''
  fi

  tmux_conf_theme_window_status_format_light="#[fg=$tmux_conf_theme_status_bg_light,bg=$tmux_conf_theme_window_status_bg_light,none]#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_bg_light" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_bg_light" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_bg_light" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}$tmux_conf_theme_left_separator_main#[fg=$tmux_conf_theme_window_status_fg_light,bg=$tmux_conf_theme_window_status_bg_light,$tmux_conf_theme_window_status_attr]#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_fg_light" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_bg_light" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_fg_light" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_bg_light" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_fg_light" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_bg_light" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}$spacer$(printf "$tmux_conf_theme_window_status_last_attr" | perl -n -e 'print "#{?window_last_flag,#[none],}" if !/default/ ; s/([a-z]+),?/#{?window_last_flag,#[\1],}/g; print if !/default/')$(printf "$tmux_conf_theme_window_status_activity_attr" | perl -n -e 'print "#{?window_activity_flag,#[none],}" if !/default/ ; s/([a-z]+),?/#{?window_activity_flag,#[\1],}/g; print if !/default/')$(printf "$tmux_conf_theme_window_status_bell_attr" | perl -n -e 'print "#{?window_bell_flag,#[none],}" if /!default/ ; s/([a-z]+),?/#{?window_bell_flag,#[\1],}/g; print if !/default/')$tmux_conf_theme_window_status_format_light#[none]$spacer#[fg=$tmux_conf_theme_window_status_bg_light,bg=$tmux_conf_theme_status_bg_light]#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_bg_light" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_bg_light" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_bg_light" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}$tmux_conf_theme_left_separator_main"

  tmux_conf_theme_window_status_format_dark="#[fg=$tmux_conf_theme_status_bg_dark,bg=$tmux_conf_theme_window_status_bg_dark,none]#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_bg_dark" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_bg_dark" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_bg_dark" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}$tmux_conf_theme_left_separator_main#[fg=$tmux_conf_theme_window_status_fg_dark,bg=$tmux_conf_theme_window_status_bg_dark,$tmux_conf_theme_window_status_attr]#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_fg_dark" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_bg_dark" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_fg_dark" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_bg_dark" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_fg_dark" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_bg_dark" | perl -n -e "s/.+/#[bg=$&]/; print if !/default/"),}$spacer$(printf "$tmux_conf_theme_window_status_last_attr" | perl -n -e 'print "#{?window_last_flag,#[none],}" if !/default/ ; s/([a-z]+),?/#{?window_last_flag,#[\1],}/g; print if !/default/')$(printf "$tmux_conf_theme_window_status_activity_attr" | perl -n -e 'print "#{?window_activity_flag,#[none],}" if !/default/ ; s/([a-z]+),?/#{?window_activity_flag,#[\1],}/g; print if !/default/')$(printf "$tmux_conf_theme_window_status_bell_attr" | perl -n -e 'print "#{?window_bell_flag,#[none],}" if /!default/ ; s/([a-z]+),?/#{?window_bell_flag,#[\1],}/g; print if !/default/')$tmux_conf_theme_window_status_format_dark#[none]$spacer#[fg=$tmux_conf_theme_window_status_bg_dark,bg=$tmux_conf_theme_status_bg_dark]#{?window_last_flag,$(printf "$tmux_conf_theme_window_status_last_bg_dark" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_activity_flag,$(printf "$tmux_conf_theme_window_status_activity_bg_dark" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}#{?window_bell_flag,$(printf "$tmux_conf_theme_window_status_bell_bg_dark" | perl -n -e "s/.+/#[fg=$&]/; print if !/default/"),}$tmux_conf_theme_left_separator_main"

  tmux_conf_theme_window_status_current_format_light="#[fg=$tmux_conf_theme_status_bg_light,bg=$tmux_conf_theme_window_status_current_bg_light,none]$tmux_conf_theme_left_separator_main#[fg=$tmux_conf_theme_window_status_current_fg_light,bg=$tmux_conf_theme_window_status_current_bg_light,$tmux_conf_theme_window_status_current_attr]$spacer_current$tmux_conf_theme_window_status_current_format_light$spacer_current#[fg=$tmux_conf_theme_window_status_current_bg_light,bg=$tmux_conf_theme_status_bg_light]$tmux_conf_theme_left_separator_main"
  tmux_conf_theme_window_status_current_format_dark="#[fg=$tmux_conf_theme_status_bg_dark,bg=$tmux_conf_theme_window_status_current_bg_dark,none]$tmux_conf_theme_left_separator_main#[fg=$tmux_conf_theme_window_status_current_fg_dark,bg=$tmux_conf_theme_window_status_current_bg_dark,$tmux_conf_theme_window_status_current_attr]$spacer_current$tmux_conf_theme_window_status_current_format_dark$spacer_current#[fg=$tmux_conf_theme_window_status_current_bg_dark,bg=$tmux_conf_theme_status_bg_dark]$tmux_conf_theme_left_separator_main"
fi

tmux_conf_theme_window_status_format_light=$(echo "$tmux_conf_theme_window_status_format_light" | sed \
  -e 's%#{circled_window_index}%#(~/.tmux/tmux_32_up/helpers/circled.sh #I)%g' \
  -e 's%#{circled_session_name}%#(~/.tmux/tmux_32_up/helpers/circled.sh #S)%g' \
  -e 's%#{username}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} false #D)%g' \
  -e 's%#{hostname}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false false #h #D)%g' \
  -e 's%#{hostname_full}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false true #H #D)%g' \
  -e 's%#{username_ssh}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} true #D)%g' \
  -e 's%#{hostname_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true false #h #D)%g' \
  -e 's%#{hostname_full_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true true #H #D)%g')
tmux_conf_theme_window_status_format_dark=$(echo "$tmux_conf_theme_window_status_format_dark" | sed \
  -e 's%#{circled_window_index}%#(~/.tmux/tmux_32_up/helpers/circled.sh #I)%g' \
  -e 's%#{circled_session_name}%#(~/.tmux/tmux_32_up/helpers/circled.sh #S)%g' \
  -e 's%#{username}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} false #D)%g' \
  -e 's%#{hostname}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false false #h #D)%g' \
  -e 's%#{hostname_full}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false true #H #D)%g' \
  -e 's%#{username_ssh}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} true #D)%g' \
  -e 's%#{hostname_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true false #h #D)%g' \
  -e 's%#{hostname_full_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true true #H #D)%g')

tmux_conf_theme_window_status_current_format_light=$(echo "$tmux_conf_theme_window_status_current_format_light" | sed \
  -e 's%#{circled_window_index}%#(~/.tmux/tmux_32_up/helpers/circled.sh #I)%g' \
  -e 's%#{circled_session_name}%#(~/.tmux/tmux_32_up/helpers/circled.sh #S)%g' \
  -e 's%#{username}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} false #D)%g' \
  -e 's%#{hostname}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false false #h #D)%g' \
  -e 's%#{hostname_full}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false true #H #D)%g' \
  -e 's%#{username_ssh}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} true #D)%g' \
  -e 's%#{hostname_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true false #h #D)%g' \
  -e 's%#{hostname_full_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true true #H #D)%g')
tmux_conf_theme_window_status_current_format_dark=$(echo "$tmux_conf_theme_window_status_current_format_dark" | sed \
  -e 's%#{circled_window_index}%#(~/.tmux/tmux_32_up/helpers/circled.sh #I)%g' \
  -e 's%#{circled_session_name}%#(~/.tmux/tmux_32_up/helpers/circled.sh #S)%g' \
  -e 's%#{username}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} false #D)%g' \
  -e 's%#{hostname}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false false #h #D)%g' \
  -e 's%#{hostname_full}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} false true #H #D)%g' \
  -e 's%#{username_ssh}%#(~/.tmux/tmux_32_up/helpers/username.sh #{pane_pid} #{b:pane_tty} true #D)%g' \
  -e 's%#{hostname_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true false #h #D)%g' \
  -e 's%#{hostname_full_ssh}%#(cat ~/.tmux/tmux_32_up/helpers/hostname.sh #{pane_pid} #{b:pane_tty} true true #H #D)%g')

# -- indicators

# #{pairing} - is session attached to more than one client?
tmux_conf_theme_pairing=${tmux_conf_theme_pairing:-⚇}                         # U+2687
tmux_conf_theme_pairing_fg_light=${tmux_conf_theme_pairing_fg_light:-none}
tmux_conf_theme_pairing_fg_dark=${tmux_conf_theme_pairing_fg_dark:-none}
tmux_conf_theme_pairing_bg_light=${tmux_conf_theme_pairing_bg_light:-none}
tmux_conf_theme_pairing_bg_dark=${tmux_conf_theme_pairing_bg_dark:-none}
tmux_conf_theme_pairing_attr=${tmux_conf_theme_pairing_attr:-none}

# #{prefix} - is prefix key binding being pressed?
tmux_conf_theme_prefix=${tmux_conf_theme_prefix:-⌨}                           # U+2328
tmux_conf_theme_prefix_fg_light=${tmux_conf_theme_prefix_fg_light:-none}
tmux_conf_theme_prefix_fg_dark=${tmux_conf_theme_prefix_fg_dark:-none}
tmux_conf_theme_prefix_bg_light=${tmux_conf_theme_prefix_bg_light:-none}
tmux_conf_theme_prefix_bg_dark=${tmux_conf_theme_prefix_bg_dark:-none}
tmux_conf_theme_prefix_attr=${tmux_conf_theme_prefix_attr:-none}

# #{mouse} - is mouse mode enabled?
tmux_conf_theme_mouse=${tmux_conf_theme_mouse:-↗}                             # U+2197
tmux_conf_theme_mouse_fg_light=${tmux_conf_theme_mouse_fg_light:-none}
tmux_conf_theme_mouse_fg_dark=${tmux_conf_theme_mouse_fg_dark:-none}
tmux_conf_theme_mouse_bg_light=${tmux_conf_theme_mouse_bg_light:-none}
tmux_conf_theme_mouse_bg_dark=${tmux_conf_theme_mouse_bg_dark:-none}
tmux_conf_theme_mouse_attr=${tmux_conf_theme_mouse_attr:-none}

# #{root} - is the current user root?
tmux_conf_theme_root=${tmux_conf_theme_root:-!}
tmux_conf_theme_root_fg_light=${tmux_conf_theme_root_fg_light:-none}
tmux_conf_theme_root_fg_dark=${tmux_conf_theme_root_fg_dark:-none}
tmux_conf_theme_root_bg_light=${tmux_conf_theme_root_bg_light:-none}
tmux_conf_theme_root_bg_dark=${tmux_conf_theme_root_bg_dark:-none}
tmux_conf_theme_root_attr=${tmux_conf_theme_root_attr:-bold,blink}

# #{synchronized} - are the panes synchronized with `set synchronized-panes on`?
tmux_conf_theme_synchronized=${tmux_conf_theme_synchronized:-⚏}               # U+268F
tmux_conf_theme_synchronized_fg_light=${tmux_conf_theme_synchronized_fg_light:-none}
tmux_conf_theme_synchronized_fg_dark=${tmux_conf_theme_synchronized_fg_dark:-none}
tmux_conf_theme_synchronized_bg_light=${tmux_conf_theme_synchronized_bg_light:-none}
tmux_conf_theme_synchronized_bg_dark=${tmux_conf_theme_synchronized_bg_dark:-none}
tmux_conf_theme_synchronized_attr=${tmux_conf_theme_synchronized_attr:-none}

# -- status-left style

tmux_conf_theme_status_left_light=${tmux_conf_theme_status_left_light-' ❐ #S | ↑#{?uptime_y, #{uptime_y}y,}#{?uptime_d, #{uptime_d}d,}#{?uptime_h, #{uptime_h}h,}#{?uptime_m, #{uptime_m}m,} '}
tmux_conf_theme_status_left_dark=${tmux_conf_theme_status_left_dark-' ❐ #S | ↑#{?uptime_y, #{uptime_y}y,}#{?uptime_d, #{uptime_d}d,}#{?uptime_h, #{uptime_h}h,}#{?uptime_m, #{uptime_m}m,} '}
tmux_conf_theme_status_left_fg_light=${tmux_conf_theme_status_left_fg_light:-colour232,colour254,colour232}
tmux_conf_theme_status_left_fg_dark=${tmux_conf_theme_status_left_fg_dark:-colour232,colour254,colour232}
tmux_conf_theme_status_left_bg_light=${tmux_conf_theme_status_left_bg_light:-colour11,colour199,colour82}
tmux_conf_theme_status_left_bg_dark=${tmux_conf_theme_status_left_bg_dark:-colour11,colour199,colour82}
tmux_conf_theme_status_left_attr=${tmux_conf_theme_status_left_attr:-bold,none,none}