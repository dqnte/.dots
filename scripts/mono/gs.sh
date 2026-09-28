#!/bin/sh
# high contrast gs for monochrome themes, status is carried by background shade and weight instead of hue
#   conflicted  bold underlined letters, name on a reversed band
#   staged      bold letters in the first column, name on a white band
#   modified    bold letter in the second column, name on a white band
#   untracked   ~ marker, italic name on a white band
# rows keep the plain "XY file" shape so ga and gr can still parse them

. ~/.dots/zsh/utils.sh
. ~/.dots/scripts/mono/palette.sh

[ -n "$1" ] && padding=$ZPADDING

nl='
'

# same letter styles as gs.sh, reset with E_ATTRS_OFF so the ink color carries on
#   deleted         strikethrough
#   renamed/copied  italics
style_letter() {
    styled=$2
    case "$1" in
        D) styled="$styled$E_STRIKE" ;;
        R|C) styled="$styled$E_ITALIC" ;;
    esac
    styled="$styled$1$E_ATTRS_OFF"
}

style_branch() {
    head=${1#'## '}
    info=""
    case "$head" in *' ['*)
        info=${head#* \[}
        info=${info%]}
        head=${head%% \[*}
    esac

    styled="$padding$E_MID*/$E_RESET "
    case "$head" in
        *...*) styled="$styled$E_REVERSE$E_BOLD ${head%%...*} $E_RESET $E_MID/= $E_ITALIC${head#*...}$E_RESET" ;;
        *' '*) styled="$styled$E_INK$E_ITALIC$head$E_RESET" ;;
        *) styled="$styled$E_REVERSE$E_BOLD $head $E_RESET" ;;
    esac

    case "$info" in *ahead*)
        ahead=${info#*ahead }
        styled="$styled $E_INK$E_BOLD+${ahead%%,*}$E_RESET"
    esac
    case "$info" in *behind*)
        styled="$styled $E_INK$E_BOLD-${info#*behind }$E_RESET"
    esac
    case "$info" in gone)
        styled="$styled $E_MID${E_STRIKE}gone$E_RESET"
    esac
}

# only the name sits on the band, padded to the longest name so the bands line up
# without -p the output feeds fzf in ga and gr, where a band would cut through the
# selection bar, so the name keeps its weight but drops the band
band() {
    if [ -z "$padding" ]; then
        row="$E_INK$4 $2$3$E_RESET"
        return
    fi
    fill=$(( width - ${#3} ))
    [ $fill -lt 0 ] && fill=0
    row="$padding$E_INK$4$E_RESET $1$2 $3$(printf '%*s' "$fill" '') $E_RESET"
}

if ! git_status=$(git status -s -b -unormal 2>&1); then
    printf '%s\n' "$git_status" | sed "s/fatal:/$E_REVERSE$E_BOLD$ZPADDING!! $E_RESET/"
    exit 1
fi

# first pass keeps "kind XY file" records and finds the widest name
branch="" records="" width=0
while IFS= read -r line; do
    case "$line" in
        '') continue ;;
        '##'*) style_branch "$line"; branch=$styled; continue ;;
    esac

    file=${line#???}
    [ ${#file} -gt $width ] && width=${#file}

    case "$line" in
        DD*|AU*|UD*|UA*|DU*|AA*|UU*) kind=c ;;
        '??'*) kind=u ;;
        ' '*) kind=m ;;
        *) kind=s ;;
    esac
    records="$records$kind$line$nl"
done <<STATUS
$git_status
STATUS

# keep bands inside the terminal, longer names just run past the band
max_width=$(( $(tput cols) - ${#padding} - 6 ))
[ $width -gt $max_width ] && width=$max_width

staged="" modified="" unmerged="" untracked=""
while IFS= read -r record; do
    [ -z "$record" ] && continue

    kind=${record%"${record#?}"}
    line=${record#?}
    rest=${line#?}
    x=${line%"$rest"}
    y=${rest%"${rest#?}"}
    file=${line#???}

    case "$kind" in
        c)
            band "$E_REVERSE" "$E_BOLD" "$file" "$E_BOLD$E_UNDERLINE$x$y$E_ATTRS_OFF"
            unmerged="$unmerged$nl$row" ;;
        u)
            band "$B_WHITE" "$E_ITALIC" "$file" " ~"
            untracked="$untracked$nl$row" ;;
        m)
            style_letter "$y" "$E_BOLD"
            band "$B_WHITE" "" "$file" " $styled"
            modified="$modified$nl$row" ;;
        s)
            partial=""
            [ "$y" != " " ] && partial=$E_UNDERLINE
            style_letter "$x" "$E_BOLD$partial"; sx=$styled
            style_letter "$y" "$E_BOLD$partial"
            band "$B_WHITE" "" "$file" "$sx$styled"
            staged="$staged$nl$row" ;;
    esac
done <<RECORDS
$records
RECORDS

# blank line after the branch, and around conflicts
output=$branch
[ -n "$staged$modified$unmerged$untracked" ] && output="$output$nl"
output="$output$staged$modified"
[ -n "$unmerged" ] && output="$output$nl$unmerged"
output="$output$untracked"

printf '%s\n' "$output"
