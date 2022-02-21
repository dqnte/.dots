#!/bin/bash

DEFAULT_THEME=dracula
declare -A ALLOWED_THEMES=( ["dracula"]=true ["ayu"]=true )

if [ $ALLOWED_THEMES[$1] ]; then
    THEME=$1
else
    THEME=$DEFAULT_THEME
fi

# kitty theme change
cp ~/.dots/kitty/$THEME.conf ~/.dots/kitty/theme.conf
kill -SIGUSR1 $(pgrep kitty)

# update zsh env
set_state_value THEME $THEME
killall -SIGUSR1 zsh
