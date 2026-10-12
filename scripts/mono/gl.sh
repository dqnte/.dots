#!/bin/sh
# high contrast gl for monochrome themes, same style as mono/gs.sh
#   hash      gray marker
#   branches  reversed chip, bold
#   tags      reversed chip, italic
#   subject   white band, padded to the longest subject so the bands line up
#   refs      chips after the band

. ~/.dots/scripts/mono/palette.sh

linecount=$1
[ -z "$linecount" ] && linecount=10

git log -n "$linecount" --format='%h%x1f%D%x1f%s' \
    --decorate-refs=refs/heads/main \
    --decorate-refs=refs/heads/master \
    --decorate-refs=refs/heads/develop \
    --decorate-refs=refs/tags \
    | awk -F '\037' \
        -v cols="$(tput cols)" -v pad="$ZPADDING" \
        -v ink="$E_INK" -v mid="$E_MID" -v white="$B_WHITE" -v reverse="$E_REVERSE" \
        -v bold="$E_BOLD" -v italic="$E_ITALIC" -v reset="$E_RESET" '
    {
        refs = ""
        refs_len = 0
        n = split($2, names, ", ")
        for (i = 1; i <= n; i++) {
            name = names[i]
            style = bold
            if (name ~ /^tag: /) { name = substr(name, 6); style = italic }
            refs = refs " " reverse style " " name " " reset
            refs_len += length(name) + 3
        }

        hashes[NR] = pad mid $1 reset " "
        refs_after[NR] = refs
        subjects[NR] = $3
        # every band shares one width, so it has to fit the row with the most chips
        room = cols - length(pad) - length($1) - 1 - refs_len - 2
        if (NR == 1 || room < min_room) min_room = room
        if (length($3) > width) width = length($3)
    }

    END {
        if (width > min_room) width = min_room
        for (i = 1; i <= NR; i++) {
            if (length(subjects[i]) > width) subjects[i] = substr(subjects[i], 1, width - 3) "..."
            fill = width - length(subjects[i])
            printf "%s%s%s %s%*s %s%s\n", hashes[i], white, ink, subjects[i], fill, "", reset, refs_after[i]
        }
    }
'
