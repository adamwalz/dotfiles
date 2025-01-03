# Load dependencies.
zenithmodload 'editor'

# Source module files.
if (( ! $+functions[history-substring-search-up] )); then
  source "${0:h}/zsh-history-substring-search/zsh-history-substring-search.zsh" || return 1
fi

#
# Search
#

zstyle -s ':zenith:module:history-substring-search:color' found \
  'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND' \
    || HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'

zstyle -s ':zenith:module:history-substring-search:color' not-found \
  'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND' \
    || HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

zstyle -s ':zenith:module:history-substring-search' globbing-flags \
  'HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS' \
    || HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

if zstyle -t ':zenith:module:history-substring-search' case-sensitive; then
  HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS="${HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS//i}"
fi

if ! zstyle -t ':zenith:module:history-substring-search' color; then
  unset HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_{FOUND,NOT_FOUND}
fi

if zstyle -t ':zenith:module:history-substring-search' fuzzy; then
  HISTORY_SUBSTRING_SEARCH_FUZZY=1
fi

if zstyle -t ':zenith:module:history-substring-search' unique; then
  HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
fi

if zstyle -t ':zenith:module:history-substring-search' prefixed; then
  HISTORY_SUBSTRING_SEARCH_PREFIXED=1
fi

#
# Key Bindings
#

if [[ -n "$key_info" ]]; then
  # Emacs
  bindkey -M emacs "$key_info[Control]P" history-substring-search-up
  bindkey -M emacs "$key_info[Control]N" history-substring-search-down

  # Vi
  bindkey -M vicmd "k" history-substring-search-up
  bindkey -M vicmd "j" history-substring-search-down

  # Emacs and Vi
  for keymap in 'emacs' 'viins'; do
    bindkey -M "$keymap" "$key_info[Up]" history-substring-search-up
    bindkey -M "$keymap" "$key_info[Down]" history-substring-search-down
  done

  unset keymap
fi
