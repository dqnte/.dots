WINDOW_POSITION="down"

[  $(tput cols) -gt 150  ] && WINDOW_POSITION="right"

branch=$(source "$HOME/.dots/scripts/gs.sh" | head -n 1)
choices=$(source "$HOME/.dots/scripts/gs.sh" \
    | tail -n +3 \
    | fzf --ansi -m --preview='echo {} | sed "s/...\(.*\)$/\1/" | xargs git diff --color | tail -n +3' \
    --preview-window="$WINDOW_POSITION" --header "$branch" --header-first \
    | sed "s/...\(.*\)$/\1/" \
)

if [ ! -z "$choices" ]; then
    echo "$choices" | xargs git add
    source "$HOME/.dots/scripts/gs.sh"
fi
