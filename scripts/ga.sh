WINDOW_POSITION="down"

[  $(tput cols) -gt 100  ] && WINDOW_POSITION="right"

git ls-files --others --exclude-standard --modified \
    | fzf --ansi -m --preview='git diff --color {} | tail -n +3' \
    --preview-window="$WINDOW_POSITION" \
    | xargs git add
