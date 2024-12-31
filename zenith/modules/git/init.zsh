# Return if requirements are not found.
if (( ! $+commands[git] )); then
  return 1
fi

# Load dependencies.
zenithmodload 'helper'

# Load 'run-help' function.
autoload -Uz run-help-git

# Source module files.
source "${0:h}/alias.zsh"
