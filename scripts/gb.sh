#!/bin/bash

header="* $(git branch --show-current) *"
if [ "$1" = "-d" ]; then
    git branch | grep '^ ' | tr -d ' ' | fzf --header "$header" -m | xargs git branch -d
elif [ "$1" = "-D" ]; then
    git branch | grep '^ ' | tr -d ' ' | fzf --header "$header" -m | xargs git branch -D
else
    git branch | grep '^ ' | tr -d ' ' | fzf --header "$header" | xargs git checkout
fi
