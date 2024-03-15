#!/bin/bash

# this was picking up incorrect parantheses... need to fix
# -e "s/^\([[:graph:]]*\) (\(.*\))/\1 ($ZITALICS$ZDIM\2$ZPLAIN)/" \
git log --oneline -n 10 --decorate | \
    sed \
    -e "s/^[[:graph:]]* /$ZPADDING$ZYELLOW&$ZPLAIN /"
