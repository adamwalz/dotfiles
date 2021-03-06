#!/bin/bash

verify_tmux_version () {
    tmux_home=~/.tmux
    tmux_version="$(tmux -V | awk '{print $2}' | sed 's/\([0-9]\{1,\}.[0-9]\{1,\}\)[a-z]\{0,1\}/\1/g')"

    if [[ $(echo "$tmux_version >= 2.1" | bc) -eq 1 ]] ; then
        tmux source-file "$tmux_home/tmux_21_up.conf"
        exit
    elif [[ $(echo "$tmux_version >= 1.9" | bc) -eq 1 ]] ; then
        tmux source-file "$tmux_home/tmux_19_to_21.conf"
        exit
    else
        tmux source-file "$tmux_home/tmux_18_down.conf"
        exit
    fi
}

verify_tmux_version
