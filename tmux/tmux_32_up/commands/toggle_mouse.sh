old=$(tmux show -gv mouse)
new=""

if [ "$old" = "on" ]; then
  new="off"
else
  new="on"
fi

tmux set -g mouse $new