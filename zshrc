# Source Zenith.
if [[ -s "${ZDOTDIR:-$HOME}/.zenith/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zenith/init.zsh"
fi

. "$HOME/.cargo/env"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
