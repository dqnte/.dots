#!/bin/sh
# high contrast fancy_ls for monochrome themes
# same grouping as fancy_ls.sh, with weight instead of hue
#   size, date   gray
#   names        white band, padded to the longest name so the bands line up
#   dirs         bold
#   executables  bold
#   links        italic, target in gray after the band
#   other        italics

. ~/.dots/scripts/mono/palette.sh

ls -ho -D '%y-%m-%d %H:%M' "$@" | awk \
    -v cols="$(tput cols)" -v pad="$ZPADDING" \
    -v ink="$E_INK" -v mid="$E_MID" -v white="$B_WHITE" \
    -v bold="$E_BOLD" -v italic="$E_ITALIC" -v off="$E_ATTRS_OFF" -v reset="$E_RESET" '
    function flush(   t, i, types, info_len, width, name, fill) {
        split("d l - o", types, " ")

        # bands share one width, cut to fit next to the size and date
        info_len = length(pad) + 6 + 16
        width = longest
        if (width > cols - info_len - 3) width = cols - info_len - 3

        for (t = 1; t <= 4; t++) {
            for (i = 1; i <= count[types[t]]; i++) {
                name = names[types[t], i]
                if (length(name) > width) name = substr(name, 1, width - 3) "..."
                fill = width - length(name)
                printf "%s%s %s%s %s%s%*s %s%s\n", pad, infos[types[t], i], white, ink, styles[types[t], i], name off, fill, "", reset, targets[types[t], i]
            }
        }
        split("", count); split("", names); split("", styles); split("", infos); split("", targets)
        longest = 0
    }

    # "total" only appears for directory listings, so single files survive
    /^total [0-9]/ { next }

    # blank lines and "dir:" headers when listing several directories
    NF < 7 { flush(); if (NF) print pad bold ink $0 reset; else print; next }

    {
        # drop perms, links, owner, size, date, and time while keeping the spacing in names
        rest = $0
        for (i = 0; i < 6; i++) sub(/^[^ ]+ +/, "", rest)

        type = substr($1, 1, 1)
        name = rest
        target = ""
        if (type == "l" && index(rest, " -> ")) {
            name = substr(rest, 1, index(rest, " -> ") - 1)
            target = " " mid "-> " substr(rest, index(rest, " -> ") + 4) reset
        }

        if (type == "d" || (type == "-" && $1 ~ /x/)) style = bold
        else if (type == "-") style = ""
        else style = italic

        if (type != "d" && type != "l" && type != "-") type = "o"
        n = ++count[type]
        names[type, n] = name
        styles[type, n] = style
        infos[type, n] = sprintf("%s%-6s%s %s  %s", mid, $4, $5, $6, reset)
        targets[type, n] = target
        if (length(name) > longest) longest = length(name)
    }

    END { flush() }
'
