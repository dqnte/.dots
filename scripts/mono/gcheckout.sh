# high contrast gcheckout for monochrome themes, errors get a reversed chip instead of red

. ~/.dots/scripts/mono/palette.sh

output=$(git checkout $1 2>&1 >/dev/null)

if echo "$output" | grep -q "error" ; then
    echo "$output" | sed -e "s/error:/$E_REVERSE$E_BOLD$ZPADDING!! $E_RESET/" \
        -e "/Please commit your changes or stash them before you switch branches./d" \
        -e "/Aborting/d"
else
    sh "$HOME/.dots/scripts/mono/gs.sh" -p | sed -e "s|\*/|>>|"
fi
