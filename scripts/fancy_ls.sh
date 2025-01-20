ls -ho --color=always -D '%y-%m-%d %T ' $@ \
    | tail -n +2 \
    | sort -r \
    | cut -w -f 4- \
    | sed -e "s/^\([[:graph:]]*\)/$ZPADDING$ZYELLOW\1$ZPLAIN/"
