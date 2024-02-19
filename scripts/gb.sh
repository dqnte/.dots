#!/bin/bash

# this can't be an alias because of how we create the fzf header
git branch | grep '^ ' | tr -d ' ' | fzf --header " $(git branch --show-current)" | xargs git checkout
