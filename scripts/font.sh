#!/bin/bash
source ~/.dots/zsh/utils.sh

DEFAULT_FONT=lisa
FONTS_DIR="$HOME/.dots/kitty/fonts"

function show_all_fonts() {
    fonts_list=$(ls $FONTS_DIR | cut -d '.' -f 1)
    echo ""
    printf "  %s\n" $fonts_list
    echo ""
}

function change_font() {
    if [ -f "$FONTS_DIR/$1.conf" ]; then
        FONT=$1
    else
        echo -e "\n  \e[3mFont not found\n\e[0m"
        exit 0
    fi

    cp $FONTS_DIR/$FONT.conf ~/.dots/kitty/font.conf

    set_state_value FONT $FONT # only really necessary for current font
    kill -s USR1 $(pgrep -a kitty)
}


if [ -z $1 ]; then
    change_font $DEFAULT_FONT
elif [ "show" = $1 ]; then
    echo -e "\n  $FONT\n"
elif [ "show-all" = $1 ]; then
    show_all_fonts
else
    change_font $1
fi
