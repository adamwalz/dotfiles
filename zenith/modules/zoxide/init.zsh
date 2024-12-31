zenithmodload 'editor'

# Check if zoxide is installed
if (( ! $+commands[zoxide] )); then
  return 1
fi

#
# Initialization
#

# Initialize zoxide with zsh integration
eval "$(zoxide init zsh)"

#
# Aliases
#

if ! zstyle -t ':zenith:module:fasd:alias' skip; then
  alias j='z'
  alias ji='zi'
fi

alias za='zoxide add'
alias zr='zoxide remove'
