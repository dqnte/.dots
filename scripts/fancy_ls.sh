#!/bin/sh
# long listing trimmed to size, modified date, and name
# grouped by type (dirs, links, files, other) and sorted by name within each group

# monochrome themes swap hue for background shade and weight, see scripts/mono/
grep -qxF "$THEME" ~/.dots/scripts/mono/themes && exec sh ~/.dots/scripts/mono/fancy_ls.sh "$@"

ls -ho --color=always -D '%y-%m-%d %H:%M ' "$@" | awk \
    -v cols="$(tput cols)" -v pad="$ZPADDING" -v yellow="$ZYELLOW" -v dim="$ZDIM" -v plain="$ZPLAIN" -v italic="$ZITALICS" '
    function flush() {
        printf "%s%s%s%s", group["d"], group["l"], group["-"], group["o"]
        split("", group)
    }

    # "total" only appears for directory listings, so single files survive
    /^total [0-9]/ { next }

    # blank lines and "dir:" headers when listing several directories
    NF < 7 { flush(); print; next }

    {
        # drop perms, links, owner, size, date, and time while keeping the spacing in names
        rest = $0
        for (i = 0; i < 4; i++) sub(/^[^ ]+ +/, "", rest)
        sub(/^[^ ]+ [^ ]+  /, "", rest)

        if ($1 ~ /^d/) rest = italic rest
        line = sprintf("%s%s%-6s%s%s%s %s%s  %s", pad, yellow, $4, plain, dim, $5, $6, plain, rest)

        # measure without escape codes so colored lines are not cut early
        visible = line
        gsub(/\033\[[0-9;]*m/, "", visible)
        if (length(visible) > cols) line = substr(visible, 1, cols - 3) "..."

        type = substr($1, 1, 1)
        if (type != "d" && type != "l" && type != "-") type = "o"
        group[type] = group[type] line "\n"
    }

    END { flush() }
'
