WINDOW_POSITION="top"

[  $(tput cols) -gt 150  ] && WINDOW_POSITION="right"

if [ ! -z "$1" ]; then
    git add $1
    source "$HOME/.dots/scripts/gs.sh" -p
    exit
fi

choices=$(source "$HOME/.dots/scripts/gs.sh" \
    | fzf --ansi -m --preview='echo {} | sed "s/...\(.*\)$/\1/" | xargs git diff --color | tail -n +3' \
    --preview-window="$WINDOW_POSITION" \
    --header-lines=2 \
    | awk 'NF>1{print $NF}'  \
)

if [ ! -z "$choices" ]; then
    echo "$choices" | xargs git add
    source "$HOME/.dots/scripts/gs.sh" -p
fi
