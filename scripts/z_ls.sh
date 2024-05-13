#!/bin/bash

MARGIN=10%

HEADER=" $ZBOLD$(pwd | sed "s=$HOME=$ZYELLOW~$ZWHITE=")"
lines=$(echo " "; LS -ap )
choice="$(echo $lines | grep -v -x -F './' | fzf --header=$HEADER --margin $MARGIN --header-lines=1)"
while [ -d "$choice" ];
do
    cd $choice
    lines=$(echo " "; LS -ap )
    HEADER=" $ZBOLD$(pwd | sed "s=$HOME=$ZYELLOW~$ZWHITE=")"
    choice="$(echo $lines | grep -v -x -F './' | fzf --header=$HEADER --margin $MARGIN --header-lines=1)"
done

if [ ! -z "$choice" ]; then
    nvim $choice
fi
