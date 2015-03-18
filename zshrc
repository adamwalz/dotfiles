#------------------------------------------------------------------------------
#          FILE:  zshrc
#   DESCRIPTION:  Executes commands at the start of an interactive session
#        AUTHOR:  Adam Walz <adam@adamwalz.net>
#       VERSION:  1.0.3
#------------------------------------------------------------------------------

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# ========================== Customize to your needs ==========================

# Source machine specific aliases
if [[ -s "${ZDOTDIR:-$HOME}/.aliases" ]]; then
  source "${ZDOTDIR:-$HOME}/.aliases"
fi

# Source environment variables generated from OS X keychain.
if [[ -s "${ZDOTDIR:-$HOME}/.env.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.env.zsh"
fi
