#!/bin/bash

DEFAULT_THEME=dracula
declare -A ALLOWED_THEMES=(
    ["dracula"]=true
    ["ayu"]=true
    ["ayu-light"]=true
    ["ayu-mirage"]=true
    ["mono"]=true
    ["monochrome"]=true
    ["melange"]=true
    ["palenight"]=true
)

if [ $ALLOWED_THEMES[$1] ]; then
    THEME=$1
else
    THEME=$DEFAULT_THEME
fi

# kitty theme change
cp ~/.dots/kitty/themes/$THEME.conf ~/.dots/kitty/theme.conf
kill -SIGUSR1 $(pgrep -a kitty)

# update zsh env
set_state_value THEME $THEME
killall -SIGUSR1 zsh
