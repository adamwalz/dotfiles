#
# Defines environment variables.
#
# Authors:
#   Adam Walz <adam@adamwalz.net>
#

if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi
