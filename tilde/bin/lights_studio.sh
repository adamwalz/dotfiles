#!/bin/bash

# LOGFILE="/Users/adamwalz/Desktop/lights_studio.log"

export PATH=$PATH:/opt/homebrew/bin

log_message() {
  if [[ -n $LOGGING ]]; then
    echo "$@" >> "$LOGFILE"
  fi
}

if [ "$1" != "on" ] && [ "$1" != "off" ]; then
  echo "Invalid argument. Please use 'on' or 'off'"
  exit 1
fi

osascript -e "display notification \"Turning studio lights $1\" with title \"lights_studio.sh\""

(/usr/bin/expect <<EOF
spawn telnet 192.168.9.231 23
expect ">"
send "set ne-softbox $1\r"
expect ">"
send "exit\r"
EOF
) 2>&1 | log_message &

(/usr/bin/expect <<EOF
spawn telnet 192.168.9.232 23
expect ">"
send "set sw-softbox $1\r"
expect ">"
send "exit\r"
EOF
) 2>&1 | log_message &

wait