#!/bin/bash

WINDOW_POSITION="top"

[  $(tput cols) -gt 150  ] && WINDOW_POSITION="right"
header=$(source "$HOME/.dots/scripts/gs.sh" | head -n 1)

MARGIN=10%
preview="xargs git log --oneline --decorate --decorate-refs=refs/heads/main --decorate-refs=refs/heads/master --decorate-refs=refs/heads/develop --decorate-refs=refs/tags --color=always"

if [ "$1" = "-d" ]; then
    git branch | grep '^ ' | fzf --header "$header" -m --margin "$MARGIN" \
        --preview-window="$WINDOW_POSITION" \
        --preview="git log --oneline --graph --decorate=short --color=always {}" \
        | xargs git branch -d
elif [ "$1" = "-D" ]; then
    git branch | grep '^ ' | fzf --header "$header" -m --margin "$MARGIN" \
        | xargs git branch -D
else
    new_branch=$(git branch | grep '^ ' | fzf --header "$header" --margin "$MARGIN" \
        --preview-window="$WINDOW_POSITION" \
        --preview="echo; echo {} | $preview" \
        | tr -d " ")
    if [ ! -z "$new_branch" ]; then
        git checkout "$new_branch" -q
        source "$HOME/.dots/scripts/gs.sh" -p
    fi
fi
