#!/bin/bash

# Functions to source files if they exist
export ZDOTDIR="$HOME/.dots/zsh"
function zsh_add_file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

function zsh_add_plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/plugins/$PLUGIN_NAME" ]; then
        # For plugins
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        git clone "https://github.com/$1.git" "$ZDOTDIR/plugins/$PLUGIN_NAME"
    fi
}

# Local state functions
function get_state_value() {
    key=$1
    echo $(grep $key ~/.dots/.state | cut -d '=' -f 2)
}

function set_state_value() {
    key=$1
    new_value=$2
    sed -i "" "s/$key=.*/$key=$new_value/" ~/.dots/.state
}

export ZBOLD="[1m"
export ZDIM="[2m"
export ZITALICS="[3m"
export ZUNDERLINE="[4m"

export ZBLACK="[30m"
export ZRED="[31m"
export ZGREEN="[32m"
export ZYELLOW="[33m"
export ZBLUE="[34m"
export ZPURPLE="[35m"
export ZCYAN="[36m"
export ZWHITE="[37m"
export ZPLAIN="[0m"
export ZPADDING="  "
