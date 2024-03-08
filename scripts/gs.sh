separator="\/="
branch_indicator="\*\/"

[ ! -z $1 ] && padding=$ZPADDING

staged_sub="s/^\(.\)\(.\)/${padding}$ZGREEN\1$ZRED\2${ZPLAIN}/1"
modified_sub="s/^ ./${padding}${ZRED}&${ZPLAIN}/"
unmerged_sub="s/^../${padding}${ZRED}&${ZPLAIN}/"
untracked_sub="s/^??/${padding}${ZPURPLE} ~${ZPLAIN}/"

git_status=$(git status -s -b -uall)
branch=$(echo "$git_status" | grep '##' | \
    sed -e "s/^## \([[:graph:]]*\)\.\.\.\([[:graph:]]\)/$padding$ZYELLOW$branch_indicator$ZPLAIN $ZBOLD\1$ZPLAIN $separator \2/"  \
    -e "s/^## \([[:graph:]]*\)$/$padding$ZYELLOW$branch_indicator$ZPLAIN $ZBOLD\1$ZPLAIN/"  \
    -e "s/^## \(.*\)/$padding$ZYELLOW$branch_indicator$ZPLAIN \1/"  \
        -e "s/ahead \([[:digit:]]*\)/$ZGREEN\+\1$ZPLAIN/" \
        -e "s/behind \([[:digit:]]*\)/$ZRED\-\1$ZPLAIN/" \
        -e "s/]\$//" \
        -e "s/ \[/ /" \
        )
staged=$(echo "$git_status" | grep '^[MTADRC]' | sed "$staged_sub" )
modified=$( echo "$git_status" | grep '^ .' | sed "$modified_sub" )
unmerged=$(echo "$git_status" | grep '^[U]' | sed "$unmerged_sub" )
untracked=$( echo "$git_status" | grep '^[!?][!?]' | sed "$untracked_sub" )

if [ -z "$staged" ] && [ -z "$modified" ] && [ -z "$untracked" ]; then
    output="$branch"
else
    output="$branch\n"
fi

[ ! -z "$staged" ] && output="$output\n$staged"
[ ! -z "$modified" ] && output="$output\n$modified"
[ ! -z "$unmerged" ] && output="$output\n\n$unmerged"
[ ! -z "$untracked" ] && output="$output\n$untracked"

[ ! -z "$git_status" ] && printf "$output\n"
