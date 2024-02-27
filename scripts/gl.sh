#!/bin/bash

git log --oneline -n 10 --decorate | \
    sed \
    -e "s/^\([[:graph:]]*\) (\(.*\))/\1 ($ZITALICS$ZDIM\2$ZPLAIN)/" \
    -e "s/^[[:graph:]]* /$ZPADDING$ZYELLOW&$ZPLAIN /"
