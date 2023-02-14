apply_important() {
  cfg=$(mktemp) && trap 'rm -f $cfg*' EXIT

  if perl -n -e 'print if /^\s*(?:set|bind|unbind).+?#!important\s*$/' ~/.tmux/tmux_32_up/tmux_32_up.conf.local 2>/dev/null > "$cfg.local"; then
    if ! tmux source-file "$cfg.local"; then
      verbose_flag=$(tmux source-file -v /dev/null 2> /dev/null && printf -- '-v' || true)
      while ! out=$(tmux source-file "$verbose_flag" "$cfg.local"); do
        line=$(printf "%s" "$out" | tail -1 | cut -d':' -f2)
        perl -n -i -e "if ($. != $line) { print }" "$cfg.local"
      done
    fi
  fi
}