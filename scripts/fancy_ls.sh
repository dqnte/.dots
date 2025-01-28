len=$(tput cols)

ls -ho --color=always -D '%y-%m-%d %T ' $@ \
    | tail -n +2 \
    | sort -r \
    | cut -w -f 4- \
    | sed -e "s/^\([[:graph:]]*\)/$ZPADDING$ZYELLOW\1$ZPLAIN/" \
    | awk -v len=$len '{ if (length($0) > len) print substr($0, 1, len) "..."; else print; }'
