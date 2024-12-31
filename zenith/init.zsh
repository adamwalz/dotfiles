#
# Version Check
#

# Check for the minimum supported version.
min_zsh_version='5.9'
if ! autoload -Uz is-at-least || ! is-at-least "$min_zsh_version"; then
  printf "zenith: old shell detected, minimum required: %s\n" "$min_zsh_version" >&2
  return 1
fi
unset min_zsh_version

#
# Module Loader
#

# Loads Zenith modules.
function zenithmodload {
  local -a zmodules
  local zmodule
  local zmodule_location
  local zfunction_glob='^([_.]*|prompt_*_setup|README*|*~)(-.N:t)'

  # $argv is overridden in the anonymous function.
  zmodules=("$argv[@]")

  # Load Zenith modules.
  for zmodule in "$zmodules[@]"; do
    if zstyle -t ":zenith:module:$zmodule" loaded 'yes' 'no'; then
      continue
    else
      zmodule_location="${ZENITHDIR}/modules/$zmodule"
      if [[ ! -d "$zmodule_location" ]]; then
        print "$0: no such module: $zmodule"
        continue
      fi

      # Add functions to $fpath.
      fpath=(${zmodule_location}/functions(-/FN) $fpath)

      function {
        local zfunction

        # Extended globbing is needed for listing autoloadable function directories.
        setopt LOCAL_OPTIONS EXTENDED_GLOB

        # Load Zenith functions.
        for zfunction in ${zmodule_location}/functions/$~zfunction_glob; do
          autoload -Uz "$zfunction"
        done
      }

      if [[ -s "${zmodule_location}/init.zsh" ]]; then
        source "${zmodule_location}/init.zsh"
      fi

      if (( $? == 0 )); then
        zstyle ":zenith:module:$zmodule" loaded 'yes'
      else
        # Remove the $fpath entry.
        fpath[(r)${zmodule_location}/functions]=()

        function {
          local zfunction

          # Extended globbing is needed for listing autoloadable function
          # directories.
          setopt LOCAL_OPTIONS EXTENDED_GLOB

          # Unload Zenith functions.
          for zfunction in ${zmodule_location}/functions/$~zfunction_glob; do
            unfunction "$zfunction"
          done
        }

        zstyle ":zenith:module:$zmodule" loaded 'no'
      fi
    fi
  done
}
#
# Zenith Initialization
#

# This finds the directory zentith is installed to so plugin managers don't need
# to rely on dirty hacks to force zenith into a directory. Additionally, it
# needs to be done here because inside the zenithmodload function ${0:h} evaluates to
# the current directory of the shell rather than the zenith dir.
ZENITHDIR=${0:h}

# Source the Zenith configuration file.
if [[ -s "${ZDOTDIR:-$HOME}/.zenithrc" ]]; then
  source "${ZDOTDIR:-$HOME}/.zenithrc"
fi

# Disable color and theme in dumb terminals.
if [[ "$TERM" == 'dumb' ]]; then
  zstyle ':zenith:*:*' color 'no'
  zstyle ':zenith:module:prompt' theme 'off'
fi

# Load Zsh modules.
zstyle -a ':zenith:load' zshmodule 'zshmodules'
for zshmodule ("$zshmodules[@]") zenithmodload "zsh/${(z)zshmodule}"
unset zshmodule{s,}

# Load more specific 'run-help' function from $fpath.
(( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help

# Autoload Zsh functions.
zstyle -a ':zenith:load' zshfunction 'zshfunctions'
for zshfunction ("$zshfunctions[@]") autoload -Uz "$zshfunction"
unset zshfunction{s,}

# Load Zenith modules.
zstyle -a ':zenith:load' zenithmodule 'zenithmodules'
zenithmodload "$zenithmodules[@]"
unset zenithmodules
