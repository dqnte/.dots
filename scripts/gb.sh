#!/bin/bash

if [ "$1" = "-d" ]; then
    git branch | grep '^ ' | tr -d ' ' | fzf --header " $(git branch --show-current)" -m | xargs git branch -d
elif [ "$1" = "-D" ]; then
    git branch | grep '^ ' | tr -d ' ' | fzf --header " $(git branch --show-current)" -m | xargs git branch -D
else
    git branch | grep '^ ' | tr -d ' ' | fzf --header " $(git branch --show-current)" -m | xargs git checkout
fi
