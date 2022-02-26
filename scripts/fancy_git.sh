function get_branch() {
    the_branch=$(git branch --show-current 2> /dev/null)
    echo "$the_branch"
}

function status() {
    branch="$(get_branch)"
    if [ -z "$branch" ]; then
        echo -e "  \e[3mNot a git repository\e[0m"
        echo
        return
    fi

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
        git stash pop 1> /dev/null
        status
    else
        git stash 1> /dev/null
    fi
}

function commit() {
    if [ "$2" = "-m" ]; then
        args="$(echo "${@:3}" | sed "s/\"/'/g")"
        git commit -m "${args}" 1> /dev/null
    else
        git $@ 1> /dev/null
    fi
    status
}

function reset() {
    git $@ 1> /dev/null
    status
}

function branch() {
    if [ -z "$2" ]; then
        branches=$(git branch | sed 's/^*.*/\\e\[1m&\\e\[0m/')
        echo -e "$branches"
    else
        git $@ | sed 's/^/  /'
    fi
}

function checkout() {
    # grab these first because getting the output of the command
    # will perform the checkout, so the current branch will change
    current_branch="$(get_branch)"
    new_branch="$2"

    output=$(git $@  2> /dev/null \
        | sed "s/'.*'/\\\e\[1m&\\\e\[0m/g" \
        | sed "s/'//g" | sed 's/^/  /g' \
        | sed '/(use.*/d' \
    )

    if [ -z "$output" ]; then
        echo -e "  Could not find branch \\e[1m$2\\e[0m"
        return
    elif [ "$current_branch" = "$new_branch" ]; then
        echo -e "  Already on branch \\e[1m$new_branch\\e[0m"
    else
        echo -e "  Switched to branch \\e[1m$new_branch\\e[0m"
    fi

    commit_info=$( echo "$output" | grep "Your branch" )
    echo -e "$commit_info"
    echo
    files=$( echo "$output" | sed '/Your branch.*/d' )
    echo -e "$files"
}

function remote() {
    if [ -z "$2" ] || [ "$2" = "-v" ]; then
        echo
        simple_pad $@
        echo
    else
        git $@
    fi
}

function simple_pad() {
    git $@ | sed 's/^/  /'
}

function main() {
    if [ "$1" = "status" ]; then
        echo
        status
    elif [ "$1" = "stash" ]; then
        stash $@
    elif [ "$1" = "commit" ]; then
        echo
        commit $@
    elif [ "$1" = "reset" ]; then
        echo
        reset $@
    elif [ "$1" = "branch" ]; then
        echo
        branch $@
        echo
    elif [ "$1" = "checkout" ]; then
        echo
        checkout $@
        echo
    elif [ "$1" = "remote" ]; then
        remote $@
    else
        git $@
    fi
}

main $@
