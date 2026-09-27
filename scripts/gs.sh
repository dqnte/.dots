#!/bin/sh

. ~/.dots/zsh/utils.sh

[ -n "$1" ] && padding=$ZPADDING

nl='
'

# letter styles, layered on top of the status colors
#   staged, modified  bold
#   partially staged  underline
#   deleted           strikethrough
#   renamed/copied    italics
#   untracked         italics
#   conflicted        bold + underline
style_letter() {
    styled=$2
    case "$1" in
        D) styled="$styled$ZSTRIKE" ;;
        R|C) styled="$styled$ZITALICS" ;;
    esac
    styled="$styled$1$ZPLAIN"
}

style_branch() {
    head=${1#'## '}
    info=""
    case "$head" in *' ['*)
        info=${head#* \[}
        info=${info%]}
        head=${head%% \[*}
    esac

    styled="$padding$ZYELLOW*/$ZPLAIN "
    case "$head" in
        *...*) styled="$styled$ZBOLD${head%%...*}$ZPLAIN /= $ZITALICS${head#*...}$ZPLAIN" ;;
        *' '*) styled="$styled$ZITALICS$head$ZPLAIN" ;;
        *) styled="$styled$ZBOLD$head$ZPLAIN" ;;
    esac

    case "$info" in *ahead*)
        ahead=${info#*ahead }
        styled="$styled $ZGREEN$ZBOLD+${ahead%%,*}$ZPLAIN"
    esac
    case "$info" in *behind*)
        styled="$styled $ZRED$ZBOLD-${info#*behind }$ZPLAIN"
    esac
    case "$info" in gone)
        styled="$styled $ZRED${ZSTRIKE}gone$ZPLAIN"
    esac
}

if ! git_status=$(git status -s -b -unormal 2>&1); then
    printf '%s\n' "$git_status" | sed "s/fatal:/$ZRED$ZPADDING!!$ZPLAIN/"
    exit 1
fi

branch="" staged="" modified="" unmerged="" untracked=""
while IFS= read -r line; do
    case "$line" in
        '') continue ;;
        '##'*) style_branch "$line"; branch=$styled; continue ;;
    esac

    rest=${line#?}
    x=${line%"$rest"}
    y=${rest%"${rest#?}"}
    file=${line#???}

    case "$x$y" in
        DD|AU|UD|UA|DU|AA|UU)
            unmerged="$unmerged$nl$padding$ZRED$ZBOLD$ZUNDERLINE$x$y$ZPLAIN $file" ;;
        '??')
            untracked="$untracked$nl$padding$ZPURPLE$ZITALICS ~$ZPLAIN $file" ;;
        ' '?)
            style_letter "$y" "$ZRED$ZBOLD"
            modified="$modified$nl$padding $styled $file" ;;
        *)
            partial=""
            [ "$y" != " " ] && partial=$ZUNDERLINE
            style_letter "$x" "$ZGREEN$ZBOLD$partial"; sx=$styled
            style_letter "$y" "$ZRED$ZBOLD$partial"
            staged="$staged$nl$padding$sx$styled $file" ;;
    esac
done <<STATUS
$git_status
STATUS

# blank line after the branch, and around conflicts
output=$branch
[ -n "$staged$modified$unmerged$untracked" ] && output="$output$nl"
output="$output$staged$modified"
[ -n "$unmerged" ] && output="$output$nl$unmerged"
output="$output$untracked"

printf '%s\n' "$output"
