#!/bin/bash
# high contrast z_ls for monochrome themes, the header path is a reversed chip instead of yellow

. ~/.dots/scripts/mono/palette.sh

MARGIN=5%

WINDOW_POSITION="right"

z_header() {
    echo " $E_REVERSE$E_BOLD $(pwd | sed "s=$HOME=~=") $E_RESET"
}

HEADER=$(z_header)
tree_cmd="tree -q -L 2 -F --gitignore --prune --filesfirst"
PREVIEW="if [ -d '{}' ]; then; $tree_cmd {} | cut -c 5- | tail -n +2 ; else; cat {}; fi"
lines=$(command ls -ap)
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
    lines=$(command ls -ap)
    HEADER=$(z_header)
    choice="$(echo $lines | grep -v -x -F './' | fzf --header=$HEADER --margin $MARGIN --preview=$PREVIEW --preview-window=$WINDOW_POSITION)"
done

unset -f z_header

if [ ! -z "$choice" ]; then
    nvim $choice
fi
