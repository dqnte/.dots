#!/bin/bash

MARGIN=5%

WINDOW_POSITION="right"


HEADER=" $ZBOLD$(pwd | sed "s=$HOME=$ZYELLOW~$ZWHITE=")"
tree_cmd="tree -q -L 2 -F --gitignore --prune --filesfirst"
PREVIEW="if [ -d '{}' ]; then; $tree_cmd {} | cut -c 5- | tail -n +2 ; else; cat {}; fi"
lines=$(LS -ap)
choice="$(echo $lines | \
    grep -v -x -F './' | \
    fzf --header=$HEADER \
        --margin $MARGIN \
        --preview=$PREVIEW \
        --preview-window=$WINDOW_POSITION \
    )"
while [ -d "$choice" ];
do
    cd $choice
    lines=$(LS -ap)
    HEADER=" $ZBOLD$(pwd | sed "s=$HOME=$ZYELLOW~$ZWHITE=")"
    choice="$(echo $lines | grep -v -x -F './' | fzf --header=$HEADER --margin $MARGIN --preview=$PREVIEW --preview-window=$WINDOW_POSITION)"
done

if [ ! -z "$choice" ]; then
    nvim $choice
fi
