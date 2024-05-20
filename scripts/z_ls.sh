#!/bin/bash

MARGIN=10%

WINDOW_POSITION="down"
[  $(tput cols) -gt 150  ] && WINDOW_POSITION="right"


HEADER=" $ZBOLD$(pwd | sed "s=$HOME=$ZYELLOW~$ZWHITE=")"
PREVIEW="if [ -d '{}' ]; then; ls {}; else; cat {}; fi"
lines=$(echo " "; LS -ap )
choice="$(echo $lines | \
    grep -v -x -F './' | \
    fzf --header=$HEADER \
        --margin $MARGIN \
        --header-lines=1 \
        --preview=$PREVIEW \
        --preview-window=$WINDOW_POSITION \
    )"
while [ -d "$choice" ];
do
    cd $choice
    lines=$(echo " "; LS -ap )
    HEADER=" $ZBOLD$(pwd | sed "s=$HOME=$ZYELLOW~$ZWHITE=")"
    choice="$(echo $lines | grep -v -x -F './' | fzf --header=$HEADER --margin $MARGIN --header-lines=1 --preview=$PREVIEW --preview-window=$WINDOW_POSITION)"
done

if [ ! -z "$choice" ]; then
    nvim $choice
fi
