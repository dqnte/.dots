bold="[1m"
black="\\\e\\[30m"
red="\\\e\\[31m"
green="\\\e\\[32m"
yellow="\\\e\\[33m"
blue="\\\e\\[34m"
purple="\\\e\\[35m"
cyan="\\\e\\[36m"
white="\\\e\\[37m"
plain="\\\e\\[0m"

separator="\/="

[ ! -z $1 ] && padding="   "

branch_sub="s/^##/${padding}${yellow}${plain}/"
staged_sub="s/^\(.\)\(.\)/${padding}$green\1$red\2${plain}/1"
modified_sub="s/^ ./${padding}${red}&${plain}/"
unmerged_sub="s/^../${padding}${red}&${plain}/"
untracked_sub="s/^??/${padding}${purple} ~${plain}/"
git_status=$(git status -s -b -uall)
branch=$(echo "$git_status" | grep '##' | \
    sed -e "s/^## \([[:graph:]]*\)\.\.\.\([[:graph:]]\)/$padding $yellow*$plain $bold\1$plain $separator \2/"  \
    -e "s/^## \([[:graph:]]*\)/$padding $yellow* $plain$bold\1$plain/"  \
        -e "s/ahead \([[:digit:]]*\)/$green\+\1$plain/" \
        -e "s/behind \([[:digit:]]*\)/$red\-\1$plain/" \
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
