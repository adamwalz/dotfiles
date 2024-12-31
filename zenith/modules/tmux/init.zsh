# Return if requirements are not found.
if (( ! $+commands[tmux] )); then
  return 1
fi

#
# Auto Start
#

if ([[ "$TERM_PROGRAM" = 'iTerm.app' ]] && \
  zstyle -t ':zenith:module:tmux:iterm' integrate \
); then
  _tmux_iterm_integration='-CC'
fi

if [[ -z "$TMUX" && -z "$EMACS" && -z "$VIM" && -z "$INSIDE_EMACS" && "$TERM_PROGRAM" != "vscode" && "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]] && ( \
  ( [[ -n "$SSH_TTY" ]] && zstyle -t ':zenith:module:tmux:auto-start' remote ) ||
  ( [[ -z "$SSH_TTY" ]] && zstyle -t ':zenith:module:tmux:auto-start' local ) \
); then
  tmux start-server

  # Create a 'zenith' session if no session has been defined in tmux.conf.
  if ! tmux has-session 2> /dev/null; then
    zstyle -s ':zenith:module:tmux:session' name tmux_session || tmux_session='zenith'
    tmux \
      new-session -d -s "$tmux_session" \; \
      set-option -t "$tmux_session" destroy-unattached off &> /dev/null
  fi

  # Attach to the 'zenith' session or to the last session used. (detach first)
  exec tmux $_tmux_iterm_integration attach-session -d
fi

#
# Aliases
#

if ! zstyle -t ':zenith:module:tmux:alias' skip; then
  alias tmuxa="tmux $_tmux_iterm_integration new-session -A"
  alias tmuxl='tmux list-sessions'
fi
