output=$(git checkout - 2>&1 >/dev/null)


echo "$output\n" | sed -e "s/^/${ZPADDING}/" \
    | sed -e "s/'/$ZBOLD/" \
    | sed -e  "s/'/$ZPLAIN/" \
    | sed -e "s/Switched to branch /$ZYELLOW>>$ZPLAIN /" \


source "$HOME/.dots/scripts/gs.sh" -p | tail -n +3

