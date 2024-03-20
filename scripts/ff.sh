
[  $(tput cols) -gt 150  ] && WINDOW_POSITION="right"

find * -type f -not -path '*node_modules/*' | fzf --preview-window="$WINDOW_POSITION" \
    --preview="cat {}" | xargs nvim
