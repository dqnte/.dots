#!/bin/bash

linecount=$1
[ -z "$linecount" ] && linecount=10

git log --oneline -n $linecount --decorate \
    --decorate-refs=refs/heads/main \
    --decorate-refs=refs/heads/master \
    --decorate-refs=refs/heads/develop \
    --decorate-refs=refs/tags --color=always \
    | sed "s/^/$ZPADDING/"
