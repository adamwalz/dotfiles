#------------------------------------------------------------------------------
#          FILE:  zshrc
#   DESCRIPTION:  Executes commands at the start of an interactive session
#        AUTHOR:  Adam Walz <adam@adamwalz.net>
#       VERSION:  1.0.1
#------------------------------------------------------------------------------

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#============================ Customize to your needs =========================
if [[ -s /opt/boxen/env.sh ]]; then
  source /opt/boxen/env.sh
fi
