function status() {
    branch=$(git branch --show-current 2> /dev/null)

    echo
    [ ! -z "$branch" ] && echo -e "  On branch \e[1m$branch\e[0m"
    git status | sed '/^On branch.*/d' \
        | sed '/^  (use.*/d' \
        | sed '/^Your branch.*/d' \
        | sed '/no changes.*/d' \
        | sed '/nothing*/d' \
        | sed 's/^\t/    /' \
        | sed 's/Changes to be committed:/  Commited:/' \
        | sed 's/Changes not staged for commit:/  Unstaged:/' \
        | sed 's/Untracked files:/  Untracked:/'
}

function stash() {
    if [ "$2" = "pop" ]; then
        suppress=$(git stash pop)
        status
    else
        suppress=$(git stash)
    fi
}

function commit() {
    if [ "$2" = "-m" ]; then
        args="-m '$3'"
    fi
    suppress=$(git commit $args)
    status
}

function reset() {
    suppress=$(git $@)
    status
}

function main() {
    if [ "$1" = "status" ]; then
        status
    elif [ "$1" = "stash" ]; then
        stash $@
    elif [ "$1" = "commit" ]; then
        commit $@
    elif [ "$1" = "reset" ]; then
        reset $@
    else
        git $@
    fi
}

main $@
