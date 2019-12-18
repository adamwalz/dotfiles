#!/bin/sh

[ $(tmux show-option -qv key-table) = 'off' ] && echo 'OFF'
