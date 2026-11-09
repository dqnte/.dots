#!/bin/sh
# high contrast tree for monochrome themes, same style as mono/fancy_ls.sh
#   root         reversed chip, bold
#   branches     gray
#   names        white band, padded so every band ends on the same column
#   dirs         bold
#   executables  bold
#   links        italic, target in gray after the band
#   other        italics
#   report       gray

. ~/.dots/scripts/mono/palette.sh

# other output formats are not drawn as a tree, pass them through untouched
for arg in "$@"; do
    case "$arg" in -J|-X|-H|-o) exec tree --gitignore "$@" ;; esac
done

# ascii branches are fixed 4 byte segments, so depth is easy to count
tree --gitignore --charset=ascii -F -n "$@" | awk \
    -v cols="$(tput cols)" -v pad="$ZPADDING" -v home="$HOME" \
    -v ink="$E_INK" -v mid="$E_MID" -v white="$B_WHITE" -v reverse="$E_REVERSE" \
    -v bold="$E_BOLD" -v italic="$E_ITALIC" -v off="$E_ATTRS_OFF" -v reset="$E_RESET" '
    {
        line = $0
        branch = ""
        depth = 0
        # an entry is any number of "|   " or "    " segments, then "|-- " or "`-- "
        while (length(line) >= 4) {
            seg = substr(line, 1, 4)
            if (seg == "|   ") branch = branch "│   "
            else if (seg == "    ") branch = branch "    "
            else if (seg == "|-- ") branch = branch "├── "
            else if (seg == "`-- ") branch = branch "╰── "
            else break
            line = substr(line, 5)
            depth++
            if (seg == "|-- " || seg == "`-- ") break
        }

        n = NR
        kinds[n] = "entry"
        if (depth == 0) {
            if (line == "") kinds[n] = "blank"
            else if (line ~ /^[0-9]+ director(y|ies)(, [0-9]+ files?)?$/) kinds[n] = "report"
            else kinds[n] = "root"
            texts[n] = line
            next
        }

        name = line
        target = ""
        style = ""
        if (index(name, " -> ")) {
            target = substr(name, index(name, " -> ") + 4)
            name = substr(name, 1, index(name, " -> ") - 1)
            style = italic
        } else if (name ~ /\/$/) {
            style = bold
        } else if (name ~ /\*$/) {
            name = substr(name, 1, length(name) - 1)
            style = bold
        } else if (name ~ /[|=]$/) {
            name = substr(name, 1, length(name) - 1)
            style = italic
        }

        branches[n] = branch
        names[n] = name
        styles[n] = style
        targets[n] = target
        widths[n] = depth * 4
        if (depth * 4 + length(name) > edge) edge = depth * 4 + length(name)
    }

    END {
        # bands all end on one column, cut to fit the terminal
        if (edge > cols - length(pad) - 3) edge = cols - length(pad) - 3

        for (i = 1; i <= NR; i++) {
            if (kinds[i] == "blank") { print ""; continue }
            if (kinds[i] == "report") { print pad mid texts[i] reset; continue }
            if (kinds[i] == "root") {
                text = texts[i]
                msg = ""
                if (index(text, "  [")) {
                    msg = " " mid substr(text, index(text, "  [") + 2) reset
                    text = substr(text, 1, index(text, "  [") - 1)
                }
                if (index(text, home) == 1) text = "~" substr(text, length(home) + 1)
                print pad reverse bold " " text " " reset msg
                continue
            }

            name = names[i]
            room = edge - widths[i]
            if (room < 4) room = 4
            if (length(name) > room) name = substr(name, 1, room - 3) "..."
            fill = room - length(name)
            target = targets[i] == "" ? "" : " " mid "-> " targets[i] reset
            printf "%s%s%s%s %s%s%s%s%*s %s%s\n", pad, mid, branches[i], white, ink, styles[i], name, off, fill, "", reset, target
        }
    }
'
