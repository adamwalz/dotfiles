#------------------------------------------------------------------------------
#          FILE:  zshenv
#   DESCRIPTION:  Defines environment variables
#        AUTHOR:  Adam Walz <adam@adamwalz.net>
#       VERSION:  1.0.0
#------------------------------------------------------------------------------

#===================================== Browser ===============================

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#===================================== Editor ===============================

export EDITOR='/usr/local/bin/subl -n'
export VISUAL='/usr/local/bin/subl -n'
export PAGER='less'

#==================================== Language ===============================

if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

#===================================== Less ==================================

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

#===================================== Path ==================================

typeset -gU cdpath fpath mailpath manpath path
typeset -gUT INFOPATH infopath

# Set the the list of directories that cd searches.
cdpath=(
  $HOME/Developer
  $cdpath
)

# Set the list of directories that info searches for manuals.
infopath=(
  $HOME/.tilde/share/info
  $HOME/.tilde/opt/share/info
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
manpath=(
  $HOME/.tilde/share/man
  $HOME/.tilde/opt/share/man
  /usr/local/share/man
  /usr/share/man
  $manpath
)

for path_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$path_file))
done
unset path_file

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/.tilde/{bin,sbin}
  $HOME/.tilde/opt/{bin,sbin}
  /usr/local/{bin,sbin}
  /usr/{bin,sbin}
  /{bin,sbin}
  $HOME/.rvm/{bin,sbin}
  $path
)

for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

#===================================== Temp Files ===============================

if [[ -d "$TMPDIR" ]]; then
  export TMPPREFIX="${TMPDIR%/}/zsh"
  if [[ ! -d "$TMPPREFIX" ]]; then
    mkdir -p "$TMPPREFIX"
  fi
fi

