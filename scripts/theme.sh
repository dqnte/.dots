#!/usr/local/bin/bash
source ~/.dots/zsh/utils.sh

DEFAULT_THEME=iceberg
declare -A ALLOWED_THEMES=(
    ["ayu"]=true
    ["dracula"]=true
    ["horizon"]=true
    ["iceberg"]=true
    ["melange"]=true
    ["mono"]=true
    ["monochrome"]=true
    ["lavender"]=true
    ["colibri"]=true
    ["palenight"]=true
    ["rose-pine"]=true
)

function show_all_themes() {
    themes_list=(${!ALLOWED_THEMES[@]})
    IFS=$'\n' themes_list=($(sort <<<"${themes_list[*]}")); unset IFS
    for theme_name in "${themes_list[@]}"; do
        echo $theme_name
    done
}

function set_kitty_theme() {
    file=$THEME
    [ "$THEME_MODE" = "light" ] && file="${THEME}_light"

    # some themes only have light files, they won't have a file without a suffix
    if [ ! -f ~/.dots/kitty/themes/$THEME.conf ]; then
        THEME_MODE="light"
        file="${THEME}_light"
    elif [ ! -f ~/.dots/kitty/themes/$file.conf ]; then
        THEME_MODE="dark"
        file=$THEME
    fi

    # kitty theme change
    cp ~/.dots/kitty/themes/$file.conf ~/.dots/kitty/theme.conf
    kill -SIGUSR1 $(pgrep -a kitty)
}

function change_theme() {
    if [ $1 = "dark" ] || [ $1 = "light" ]; then
        THEME_MODE="$1"
    elif [ "${ALLOWED_THEMES[$1]}" ]; then
        THEME=$1
    else
        THEME=$DEFAULT_THEME
    fi

    set_kitty_theme

    # update zsh env
    set_state_value THEME $THEME
    set_state_value THEME_MODE $THEME_MODE
    killall -SIGUSR1 zsh

    # update nvim instances
    # nvr  --serverlist | while read line; do
    #     nvr --servername $line --remote-send "<esc>:let \$THEME = \"$THEME\"<enter>"
    #     nvr --servername $line --remote-send "<esc>:source ~/.dots/nvim/init.lua<enter>"
    # done
}

if [ -z $1 ]; then
    change_theme $DEFAULT_THEME
elif [ "show" = $1 ]; then
    echo $THEME
elif [ "show-all" = $1 ]; then
    show_all_themes
else
    change_theme $1
fi
