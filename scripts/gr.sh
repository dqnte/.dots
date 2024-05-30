choices=$(source "$HOME/.dots/scripts/gs.sh" \
    | fzf --ansi -m --preview='echo {} | sed "s/...\(.*\)$/\1/" | xargs git diff --color | tail -n +3' \
    --preview-window="$WINDOW_POSITION" \
    --header-lines=2 \
    | awk 'NF>1{print $NF}'  \
)

echo "$choices"
