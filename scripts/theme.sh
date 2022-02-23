#!/usr/local/bin/bash
source ~/.dots/zsh/utils.sh

DEFAULT_THEME=dracula
declare -A ALLOWED_THEMES=(
    ["ayu"]=true
<<<<<<< Updated upstream
    ["ayu-light"]=true
    ["ayu-mirage"]=true
    ["dracula"]=true
=======
    ["dracula"]=true
    ["horizon"]=true
>>>>>>> Stashed changes
    ["melange"]=true
    ["mono"]=true
    ["monochrome"]=true
    ["palenight"]=true
)

function show_all_themes() {
    themes_list=(${!ALLOWED_THEMES[@]})
    IFS=$'\n' themes_list=($(sort <<<"${themes_list[*]}")); unset IFS
    for theme_name in "${themes_list[@]}"; do
        echo $theme_name
    done
}

function change_theme() {
    if [ "${ALLOWED_THEMES[$1]}" ]; then
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
