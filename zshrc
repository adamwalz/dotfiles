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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/Users/adamwalz/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#else
#    if [ -f "/Users/adamwalz/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/Users/adamwalz/anaconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/Users/adamwalz/anaconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
# <<< conda initialize <<<

