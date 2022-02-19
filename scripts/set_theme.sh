#!/bin/bash

export THEME=$1
[ -z "$1" ] && export THEME=dracula

# vim theme change
new_line="\[ -z \$THEME \] \&\& export THEME=$THEME"
sed -i "" "4s/.*/$new_line/" ~/.dots/zsh/aesthetic.sh

# kitty theme change
new_line="include ~\/.dots\/kitty\/$THEME.conf"
sed -i "" "1s/.*/$new_line/" ~/.dots/kitty/kitty.conf
