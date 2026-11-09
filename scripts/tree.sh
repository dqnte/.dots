#!/bin/sh
# tree that respects .gitignore, drawn in the same style as gs and gl
#   root         yellow, bold
#   branches     dim
#   dirs         blue, bold
#   executables  green, bold
#   links        cyan italic, target dim
#   other        purple italic
#   report       dim

# monochrome themes swap hue for background shade and weight, see scripts/mono/
grep -qxF "$THEME" ~/.dots/scripts/mono/themes && exec sh ~/.dots/scripts/mono/tree.sh "$@"

# other output formats are not drawn as a tree, pass them through untouched
for arg in "$@"; do
    case "$arg" in -J|-X|-H|-o) exec tree --gitignore "$@" ;; esac
done

# ascii branches are fixed 4 byte segments, so depth is easy to count
tree --gitignore --charset=ascii -F -n "$@" | awk \
    -v pad="$ZPADDING" -v home="$HOME" \
    -v yellow="$ZYELLOW" -v blue="$ZBLUE" -v green="$ZGREEN" -v cyan="$ZCYAN" -v purple="$ZPURPLE" -v red="$ZRED" \
    -v bold="$ZBOLD" -v dim="$ZDIM" -v italic="$ZITALICS" -v plain="$ZPLAIN" '
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

        if (depth == 0) {
            if (line == "") print ""
            else if (line ~ /^[0-9]+ director(y|ies)(, [0-9]+ files?)?$/) print pad dim line plain
            else {
                msg = ""
                if (index(line, "  [")) {
                    msg = " " red substr(line, index(line, "  [") + 2) plain
                    line = substr(line, 1, index(line, "  [") - 1)
                }
                if (index(line, home) == 1) line = "~" substr(line, length(home) + 1)
                print pad yellow bold line plain msg
            }
            next
        }

        name = line
        target = ""
        style = ""
        if (index(name, " -> ")) {
            target = " " dim "-> " substr(name, index(name, " -> ") + 4) plain
            name = substr(name, 1, index(name, " -> ") - 1)
            style = cyan italic
        } else if (name ~ /\/$/) {
            style = blue bold
        } else if (name ~ /\*$/) {
            name = substr(name, 1, length(name) - 1)
            style = green bold
        } else if (name ~ /[|=]$/) {
            name = substr(name, 1, length(name) - 1)
            style = purple italic
        }

        print pad dim branch plain style name plain target
    }
'
