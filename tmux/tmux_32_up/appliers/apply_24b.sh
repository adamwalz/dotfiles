# Sets terminal color depth to 24-bit if the terminal supports it
# 
# Side effects:
#   Setting the terminal color depth: If the terminal supports 24-bit color and the function
#     determines that it is supported, it sets the terminal color depth to 24-bit in Tmux.
#     This will affect the way that Tmux displays colors in the terminal.
#   Setting Tmux options: The function sets the terminal-overrides option in Tmux if the terminal
#     does not start with screen- or tmux-. This will change the behavior of Tmux in some way,
#     although the exact effect is not specified in this function.
#   Modifying environment variables: The function sets two environment variables,
#     tmux_conf_theme_24b_color and tmux_conf_24b_color, which could potentially affect other
#     parts of the system that rely on these variables.
apply_24b() {
  source "$(dirname "$(readlink -f "$0")")/helpers/helpers.sh"

  tmux_conf_theme_24b_color=${tmux_conf_theme_24b_color:-auto}
  tmux_conf_24b_color=${tmux_conf_24b_color:-$tmux_conf_theme_24b_color}
  if [ x"$tmux_conf_24b_color" = x"auto" ]; then
    case "$COLORTERM" in
      truecolor|24bit)
        apply_24b=true
        ;;
    esac
    if [ x"$apply_24b" = x"" ] && [ x"$(tput colors)" = x"16777216" ]; then
      apply_24b=true
    fi
  elif is_true "$tmux_conf_24b_color"; then
    apply_24b=true
  fi
  if [ x"$apply_24b" = x"true" ]; then
    case "$TERM" in
      screen-*|tmux-*)
        ;;
      *)
        tmux set-option -ga terminal-overrides ",*256col*:Tc"
        ;;
    esac
  fi
}