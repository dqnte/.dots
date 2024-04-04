#!/bin/bash

header=$(source "$HOME/.dots/scripts/gs.sh" | head -n 1)
HEIGHT=25%
MARGIN=0%

if [ "$1" = "-d" ]; then
    git branch | grep '^ ' | fzf --header "$header" -m --height "$HEIGHT" --margin "$MARGIN" | xargs git branch -d
elif [ "$1" = "-D" ]; then
    git branch | grep '^ ' | fzf --header "$header" -m --height "$HEIGHT" --margin "$MARGIN" | xargs git branch -D
else
    new_branch=$(git branch | grep '^ ' | fzf --header "$header" --height "$HEIGHT" --margin "$MARGIN" | tr -d " ")
    if [ ! -z "$new_branch" ]; then
        git checkout "$new_branch" -q
        source "$HOME/.dots/scripts/gs.sh" -p
    fi
fi
