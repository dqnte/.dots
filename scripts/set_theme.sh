#!/bin/bash

declare -A allowed_themes=( ["dracula"]=true ["ayu"]=true)
if [ -z $allowed_themes[$1] ]; then
    export THEME=dracula
else
    export THEME="$1"
fi

# vim theme change
new_line="\[ -z \$THEME \] \&\& export THEME=$THEME"
sed -i "" "4s/.*/$new_line/" ~/.dots/zsh/aesthetic.sh

# kitty theme change
new_line="include ~\/.dots\/kitty\/$THEME.conf"
sed -i "" "1s/.*/$new_line/" ~/.dots/kitty/kitty.conf

# reload kitty
kill -SIGUSR1 $(pgrep kitty)
