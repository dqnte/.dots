#!/bin/bash

HEADER="$(pwd | sed "s=$HOME=~=")"
choice="$(LS -ap | grep -v -x -F './' | fzf --header=$HEADER)"
while [ -d "$choice" ];
do
    cd $choice
    HEADER="$(pwd | sed "s=$HOME=~=")"
    choice="$(LS -ap | grep -v -x -F './' | fzf --header=$HEADER)"
done

if [ ! -z "$choice" ]; then
    nvim $choice
fi
