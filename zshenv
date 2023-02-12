#------------------------------------------------------------------------------
#          FILE:  zshenv
#   DESCRIPTION:  Defines environment variables
#        AUTHOR:  Adam Walz <adam@adamwalz.net>
#       VERSION:  2.0.0
#------------------------------------------------------------------------------

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
