output=$(git checkout - 2>&1 >/dev/null)

if echo "$output" | grep -q "error" ; then
    echo "$output" | sed -e "s/error:/$ZRED$ZPADDING!!$ZPLAIN/" \
        -e "/Please commit your changes or stash them before you switch branches./d" \
        -e "/Aborting/d"
else
    echo "$output\n" | sed -e "s/^/${ZPADDING}/" \
        -e "s/'/$ZBOLD/" \
        -e  "s/'/$ZPLAIN/" \
        -e "s/Switched to branch /$ZYELLOW>>$ZPLAIN /"

    source "$HOME/.dots/scripts/gs.sh" -p | tail -n +3
fi
