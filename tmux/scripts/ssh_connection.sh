#!/bin/sh

tmux show-environment SSH_CONNECTION | awk -F= '{print $2}'
