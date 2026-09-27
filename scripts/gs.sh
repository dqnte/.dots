separator="\/="
branch_indicator="\*\/"

[ ! -z $1 ] && padding=$ZPADDING

# fall back to raw escapes in case the shell hasn't sourced utils.sh
esc=$(printf '\033')
: ${ZBOLD:="$esc[1m"} ${ZDIM:="$esc[2m"} ${ZITALICS:="$esc[3m"}
: ${ZUNDERLINE:="$esc[4m"} ${ZSTRIKE:="$esc[9m"} ${ZPLAIN:="$esc[0m"}

# letter styles, layered on top of the status colors
#   staged, modified  bold
#   partially staged  underline
#   deleted           strikethrough
#   renamed/copied    italics
#   untracked         italics
#   conflicted        bold + underline
style_letter() {
    letter=$1 style=$2

    case "$letter" in
        D) style="$style$ZSTRIKE" ;;
        R|C) style="$style$ZITALICS" ;;
    esac

    printf "%s" "$style$letter$ZPLAIN"
}

git_status=$(git status -s -b -uall 2>&1)
if echo "$git_status" | grep -q "fatal:" ; then
    echo "$git_status" | sed -e "s/fatal:/$ZRED$ZPADDING!!$ZPLAIN/"
    exit 1
fi

branch=$(echo "$git_status" | grep '##' | \
    sed -e "s/^## \([[:graph:]]*\)\.\.\.\([[:graph:]]*\)/$padding$ZYELLOW$branch_indicator$ZPLAIN $ZBOLD\1$ZPLAIN $separator $ZITALICS\2$ZPLAIN/"  \
    -e "s/^## \([[:graph:]]*\)$/$padding$ZYELLOW$branch_indicator$ZPLAIN $ZBOLD\1$ZPLAIN/"  \
    -e "s/^## \(.*\)/$padding$ZYELLOW$branch_indicator$ZPLAIN $ZITALICS\1$ZPLAIN/"  \
        -e "s/ahead \([[:digit:]]*\)/$ZGREEN$ZBOLD\+\1$ZPLAIN/" \
        -e "s/behind \([[:digit:]]*\)/$ZRED$ZBOLD\-\1$ZPLAIN/" \
        -e "s/gone/$ZRED$ZSTRIKE&$ZPLAIN/" \
        -e "s/]\$//" \
        -e "s/ \[/ /" \
        )

staged="" modified="" unmerged="" untracked=""
nl='
'
while IFS= read -r line; do
    case "$line" in '##'*|'') continue ;; esac

    rest=${line#?}
    x=${line%"$rest"}
    y=${rest%"${rest#?}"}
    file=${line#???}

    partial=""
    [ "$x" != " " ] && [ "$y" != " " ] && partial="$ZUNDERLINE"

    case "$x$y" in
        DD|AU|UD|UA|DU|AA|UU)
            unmerged="$unmerged$nl$padding$ZRED$ZBOLD$ZUNDERLINE$x$y$ZPLAIN $file" ;;
        '??')
            untracked="$untracked$nl$padding$ZPURPLE$ZITALICS ~$ZPLAIN $file" ;;
        ' '?)
            modified="$modified$nl$padding $(style_letter "$y" "$ZRED$ZBOLD") $file" ;;
        *)
            staged="$staged$nl$padding$(style_letter "$x" "$ZGREEN$ZBOLD$partial")$(style_letter "$y" "$ZRED$ZBOLD$partial") $file" ;;
    esac
done <<STATUS
$git_status
STATUS

staged=${staged#"$nl"}
modified=${modified#"$nl"}
unmerged=${unmerged#"$nl"}
untracked=${untracked#"$nl"}

if [ -z "$staged" ] && [ -z "$modified" ] && [ -z "$unmerged" ] && [ -z "$untracked" ]; then
    output="$branch"
else
    output="$branch\n"
fi

[ ! -z "$staged" ] && output="$output\n$staged"
[ ! -z "$modified" ] && output="$output\n$modified"
[ ! -z "$unmerged" ] && output="$output\n\n$unmerged"
[ ! -z "$untracked" ] && output="$output\n$untracked"

[ ! -z "$git_status" ] && printf "%b\n" "$output"
