# monochrome themes swap hue for background shade and weight, see scripts/mono/
grep -qxF "$THEME" ~/.dots/scripts/mono/themes && exec sh ~/.dots/scripts/mono/gcheckout.sh "$@"

output=$(git checkout $1 2>&1 >/dev/null)

if echo "$output" | grep -q "error" ; then
    echo "$output" | sed -e "s/error:/$ZRED$ZPADDING!!$ZPLAIN/" \
        -e "/Please commit your changes or stash them before you switch branches./d" \
        -e "/Aborting/d"
else
    source "$HOME/.dots/scripts/gs.sh" -p | sed -e "s|*/|>>|"
fi
