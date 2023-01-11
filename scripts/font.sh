#!/usr/local/bin/bash

DEFAULT_FONT=fira
declare -A ALLOWED_FONTS=(
    ["lisa"]=true
    ["fira"]=true
    ["jet"]=true
)

function show_all_fonts() {
    fonts_list=(${!ALLOWED_FONTS[@]})
    IFS=$'\n' fonts_list=($(sort <<<"${themes_list[*]}")); unset IFS
    for font_name in "${fonts_list[@]}"; do
        echo $font_name
    done
}

function change_font() {
    if [ "${ALLOWED_FONTS[$1]}" ]; then
        FONT=$1
    else
        FONT=$DEFAULT_FONT
    fi

    cp ~/.dots/kitty/fonts/$FONT.conf ~/.dots/kitty/font.conf
    kill -SIGUSR1 $(pgrep -a kitty)
}


if [ -z $1 ]; then
    change_font $DEFAULT_FONT
elif [ "show" = $1 ]; then
    echo $THEME
elif [ "show-all" = $1 ]; then
    show_all_fonts
else
    change_font $1
fi
