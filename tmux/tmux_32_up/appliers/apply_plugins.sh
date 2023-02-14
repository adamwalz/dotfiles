apply_plugins() {
  window_active="$1"
  tmux_conf_update_plugins_on_launch="$2"
  tmux_conf_update_plugins_on_reload="$3"
  tmux_conf_uninstall_plugins_on_reload="$4"

  TMUX_PLUGIN_MANAGER_PATH=${TMUX_PLUGIN_MANAGER_PATH:-~/.tmux/plugins}
  if [ -z "$(tmux show -gv '@plugin')" ] && [ -z "$(tmux show -gv '@tpm_plugins')" ]; then
    if _is_true "$tmux_conf_uninstall_plugins_on_reload" && [ -d "$TMUX_PLUGIN_MANAGER_PATH/tpm" ]; then
      tmux display 'Uninstalling tpm and plugins...'
      rm -rf "$TMUX_PLUGIN_MANAGER_PATH"
      tmux display 'Done uninstalling tpm and plugins...'
    fi
  else
    if git ls-remote -hq https://github.com/adamwalz/dotfiles.git master > /dev/null; then
      if [ ! -d "$TMUX_PLUGIN_MANAGER_PATH/tpm" ]; then
        install_tpm=true
        tmux display 'Installing tpm and plugins...'
        git clone --depth 1 https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_MANAGER_PATH/tpm"
      elif { [ -z "$window_active" ] && _is_true "$tmux_conf_update_plugins_on_launch"; } || { [ -n "$window_active" ] && _is_true "$tmux_conf_update_plugins_on_reload"; }; then
        update_tpm=true
        tmux display 'Updating tpm and plugins...'
        (cd "$TMUX_PLUGIN_MANAGER_PATH/tpm" && git fetch -q -p && git checkout -q master && git reset -q --hard origin/master)
      fi
      if [ x"$install_tpm" = x"true" ] || [ x"$update_tpm" = x"true" ]; then
        perl -0777 -p -i -e 's/git clone(?!\s+--depth\s+1)/git clone --depth 1/g
                            ;s/(install_plugin(.(?!&))*)\n(\s+)done/\1&\n\3done\n\3wait/g' "$TMUX_PLUGIN_MANAGER_PATH/tpm/scripts/install_plugins.sh"
        perl -p -i -e 's/git submodule update --init --recursive(?!\s+--depth\s+1)/git submodule update --init --recursive --depth 1/g' "$TMUX_PLUGIN_MANAGER_PATH/tpm/scripts/update_plugin.sh"
        perl -p -i -e 's,\$tmux_file\s+>/dev/null\s+2>\&1,$& || { tmux display "Plugin \$(basename \${plugin_path}) failed" && false; },' "$TMUX_PLUGIN_MANAGER_PATH/tpm/scripts/source_plugins.sh"
        tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "$TMUX_PLUGIN_MANAGER_PATH"
      fi
      if [ x"$update_tpm" = x"true" ]; then
        {
          echo "Invoking $TMUX_PLUGIN_MANAGER_PATH/tpm/bin/install_plugins ..." > "$TMUX_PLUGIN_MANAGER_PATH/tpm_log.txt" 2>&1 && \
          "$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/install_plugins" >> "$TMUX_PLUGIN_MANAGER_PATH/tpm_log.txt" 2>&1     &&\
          echo "Invoking $TMUX_PLUGIN_MANAGER_PATH/tpm/bin/update_plugins all ..." > "$TMUX_PLUGIN_MANAGER_PATH/tpm_log.txt" 2>&1 && \
          "$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/update_plugins" all >> "$TMUX_PLUGIN_MANAGER_PATH/tpm_log.txt" 2>&1  &&\
          echo "Invoking $TMUX_PLUGIN_MANAGER_PATH/tpm/bin/clean_plugins all ..." > "$TMUX_PLUGIN_MANAGER_PATH/tpm_log.txt" 2>&1 && \
          "$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/clean_plugins" all >> "$TMUX_PLUGIN_MANAGER_PATH/tpm_log.txt" 2>&1   &&\
          tmux display 'Done updating tpm and plugins...'
        } || tmux display 'Failed updating tpm and plugins...'
      elif [ x"$install_tpm" = x"true" ]; then
        {
          echo "Invoking $TMUX_PLUGIN_MANAGER_PATH/tpm/bin/install_plugins ..." > "$TMUX_PLUGIN_MANAGER_PATH/tpm_log.txt" 2>&1 && \
          "$TMUX_PLUGIN_MANAGER_PATH/tpm/bin/install_plugins" >> "$TMUX_PLUGIN_MANAGER_PATH/tpm_log.txt" 2>&1
          tmux display 'Done installing tpm and plugins...'
        } || tmux display 'Failed installing tpm and plugins...'
      fi
    else
      tmux display "GitHub doesn't seem to be reachable, skipping installing and/or updating tpm and plugins..."
    fi

    [ -z "$(tmux show -gqv '@tpm-install')" ] && tmux set -g '@tpm-install' 'I'
    [ -z "$(tmux show -gqv '@tpm-update')" ] && tmux set -g '@tpm-update' 'u'
    [ -z "$(tmux show -gqv '@tpm-clean')" ] && tmux set -g '@tpm-clean' 'M-u'
    [ -f "$TMUX_PLUGIN_MANAGER_PATH/tpm/tpm" ] && "$TMUX_PLUGIN_MANAGER_PATH/tpm/tpm" || tmux display "One or more tpm plugin(s) failed"
    if [ $_tmux_version -gt 260 ]; then
      tmux set -gu '@tpm-install' \; set -gu '@tpm-update' \; set -gu '@tpm-clean' \; set -gu '@plugin'
    fi
  fi

  if [ -z "$window_active" ] && [ $_tmux_version -lt 240 ]; then
    tmux run -b "sleep $(expr $(tmux display -p '#{display-time}') / 500) && tmux set display-time 3000 \; display 'This configuration will soon require tmux 2.4+' \; set -u display-time"
  fi
}