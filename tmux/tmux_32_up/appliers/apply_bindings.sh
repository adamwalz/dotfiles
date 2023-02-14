# Apply custom key bindings to the `tmux` configuration.
#
# This function modifies the output of the `tmux list-keys` command to apply custom
# bindings. The custom bindings are defined based on the values of the following
# environment variables:
#
# - `tmux_conf_new_window_retain_current_path`: If set to true, the new window will be
#   created in the current path of the pane. The default value is false.
# - `tmux_conf_new_pane_retain_current_path`: If set to true, the new pane will be created
#   in the current path of the parent pane. The default value is true.
#
# The function uses `perl` to perform regular expression substitution on the output of
# `tmux list-keys`.
apply_bindings() {
  cfg=$(mktemp) && trap 'rm -f $cfg*' EXIT

  tmux list-keys | grep -vF 'tmux_32_up.conf' | grep -E 'new-window|split(-|_)window|new-session|copy-selection|copy-pipe' > "$cfg"

  # tmux 3.0 doesn't include 02254d1e5c881be95fd2fc37b4c4209640b6b266 and the
  # output of list-keys can be truncated
  perl -p -i -e "s/'#\{\?window_zoomed_flag,Unzoom,Zoom\}' 'z' \{resize-pane -$/'#{?window_zoomed_flag,Unzoom,Zoom}' 'z' {resize-pane -Z}\"/g" "$cfg"

  tmux_conf_new_window_retain_current_path=${tmux_conf_new_window_retain_current_path:-false}
  if ! _is_disabled "$tmux_conf_new_window_retain_current_path"; then
    perl -p -i -e "
      s/\bnew-window\b([^;}\n]*?)(?:\s+-c\s+((?:\\\\\")?|\"?|'?)#\{pane_current_path\}\2)/new-window\1/g" \
      "$cfg"
  fi

  tmux_conf_new_pane_retain_current_path=${tmux_conf_new_pane_retain_current_path:-true}
  if ! _is_disabled "$tmux_conf_new_pane_retain_current_path"; then
    perl -p -i -e "
      s/\brun-shell\b\s+(\"|')~\/\.tmux\/tmux_32_up\/split_window\.sh\s+#\{b:pane_tty\}([^\n\1]*)(\s+-c\s+((?:\\\\\")?|\"?|'?)#\{pane_current_path\}\4)([^\n\1]*)\1/run-shell \1~\/.tmux\/tmux_32_up\/split_window.sh #{pane_pid} #{b:pane_tty}\2\5\1/g
      ;
      s/\brun-shell\b(\s+((?:\\\\\")?|\"?|'?)~\/\.tmux\/tmux_32_up\/split_window\.sh\s+((?:\\\\\")?|\"?|'?)#\{b:pane_tty\}\3)(.*?)\2/split-window\4/g
      ;
      s/\bsplit-window\b([^;}\n]*?)(?:\s+-c\s+((?:\\\\\")?|\"?|'?)#\{pane_current_path\}\2)/split-window\1/g" \
      "$cfg"
  fi

  if ! _is_disabled "$tmux_conf_new_window_retain_current_path"; then
    if _is_true "$tmux_conf_new_window_retain_current_path"; then
      perl -p -i -e "
        s/\bnew-window\b(?!\s+(?:-|}))/{$&}/g if /\bdisplay-menu\b/
        ;
        s/\bnew-window\b/new-window -c '#\{pane_current_path\}'/g" \
        "$cfg"
    fi
  fi

  perl -p -i -e "
    s/\bsplit-window\b((?:(?:[ \t]+-[bdfhIvP])|(?:[ \t]+-[celtF][ \t]+(?!\bssh\b)[^\s]+))*)?(?:\s+(\bssh\b))((?:(?:[ \t]+-[bdfhIvP])|(?:[ \t]+-[celtF][ \t]+(?!\bssh\b)[^\s]+))*)?/run-shell '~\/\.tmux\/tmux_32_up\/split_window_ssh\.sh #\{pane_pid\} #\{b:pane_tty\}\1'/g if /\bsplit-window\b((?:(?:[ \t]+-[bdfhIvP])|(?:[ \t]+-[celtF][ \t]+(?!ssh)[^\s]+))*)?(?:\s+(ssh))((?:(?:[ \t]+-[bdfhIvP])|(?:[ \t]+-[celtF][ \t]+(?!ssh)[^\s]+))*)?/"\
  "$cfg"

  tmux_conf_new_pane_reconnect_ssh=${tmux_conf_new_pane_reconnect_ssh:-false}
  if ! _is_disabled "$tmux_conf_new_pane_reconnect_ssh" && _is_true "$tmux_conf_new_pane_reconnect_ssh"; then
    perl -p -i -e "s/\bsplit-window\b([^;}\n\"]*)/run-shell '~\/\.tmux\/tmux_32_up\/split_window\.sh #\{pane_pid\} #\{b:pane_tty\}\1'/g" "$cfg"
  fi

  if ! _is_disabled "$tmux_conf_new_pane_retain_current_path" && _is_true "$tmux_conf_new_pane_retain_current_path"; then
    perl -p -i -e "
      s/\bsplit-window\b(?!\s+(?:-|}))/{$&}/g if /\bdisplay-menu\b/
      ;
      s/\bsplit-window\b/split-window -c '#{pane_current_path}'\1/g
      ;
      s/\brun-shell\b\s+'cat\s+~\/\.tmux\/tmux_32_up\/split_window(_ssh)?\.sh\s+#\{pane_pid\}\s+#\{b:pane_tty\}([^}\n']*)'/run-shell '~\/.tmux\/tmux_32_up\/split_window\1.sh #\{pane_pid\} #\{b:pane_tty\} -c \\\\\"#\{pane_current_path\}\\\\\"\2'/g if /\bdisplay-menu\b/
      ;
      s/\brun-shell\b\s+'cat\s+~\/\.tmux\/tmux_32_up\/split_window(_ssh)?\.sh\s+#\{pane_pid\}\s+#\{b:pane_tty\}([^}\n']*)'/run-shell '~\/.tmux\/tmux_32_up\/split_window\1.sh #\{pane_pid\} #\{b:pane_tty\} -c \"#\{pane_current_path\}\"\2'/g" \
      "$cfg"
  fi

  tmux_conf_new_session_prompt=${tmux_conf_new_session_prompt:-false}
  if ! _is_disabled "$tmux_conf_new_session_prompt" && _is_true "$tmux_conf_new_session_prompt"; then
    perl -p -i \
      -e "s/(?<!command-prompt -p )\b(new-session)\b(?!\s+(?:-|}))/{$&}/g if /\bdisplay-menu\b/" \
      -e ';' \
      -e "s/(?<!\bcommand-prompt -p )\bnew-session\b(?! -s)/command-prompt -p new-session 'new-session -s \"%%\"'/g" \
      "$cfg"
  else
    perl -p -i -e "s/\bcommand-prompt\s+-p\s+new-session\s+'new-session\s+-s\s+\"%%\"'/new-session/g" "$cfg"
  fi

  tmux_conf_copy_to_os_clipboard=${tmux_conf_copy_to_os_clipboard:-false}
  command -v xsel > /dev/null 2>&1 && command='xsel -i -b'
  ! command -v xsel > /dev/null 2>&1 && command -v xclip > /dev/null 2>&1 && command='xclip -i -selection clipboard > \/dev\/null 2>\&1'
  command -v pbcopy > /dev/null 2>&1 && command='pbcopy'
  command -v reattach-to-user-namespace > /dev/null 2>&1 && command='reattach-to-user-namespace pbcopy'
  command -v clip.exe > /dev/null 2>&1 && command='clip\.exe'
  [ -c /dev/clipboard ] && command='cat > \/dev\/clipboard'

  if [ -n "$command" ]; then
    if ! _is_disabled "$tmux_conf_copy_to_os_clipboard" && _is_true "$tmux_conf_copy_to_os_clipboard"; then
      perl -p -i -e "s/(?!.*?$command)\bcopy-(?:selection|pipe)(-and-cancel)?\b/copy-pipe\1 '$command'/g" "$cfg"
    else
      if [ $_tmux_version -ge 320 ]; then
        perl -p -i -e "s/\bcopy-pipe(-and-cancel)?\b\s+(\"|')?$command\2?/copy-pipe\1/g" "$cfg"
      else
        perl -p -i -e "s/\bcopy-pipe(-and-cancel)?\b\s+(\"|')?$command\2?/copy-selection\1/g" "$cfg"
      fi
    fi
  fi

  # until tmux >= 3.0, output of tmux list-keys can't be consumed back by tmux source-file without applying some escapings
  awk < "$cfg" \
    '{i = $2 == "-T" ? 4 : 5; gsub(/^[;]$/, "\\\\&", $i); gsub(/^[$"#~]$/, "'"'"'&'"'"'", $i); gsub(/^['"'"']$/, "\"&\"", $i); print}' > "$cfg.in"

  # ignore bindings with errors
  if ! tmux source-file "$cfg.in"; then
    verbose_flag=$(tmux source-file -v /dev/null 2> /dev/null && printf -- '-v' || true)
    while ! out=$(tmux source-file "$verbose_flag" "$cfg.in"); do
      line=$(printf "%s" "$out" | tail -1 | cut -d':' -f2)
      perl -n -i -e "if ($. != $line) { print }" "$cfg.in"
    done
  fi
}