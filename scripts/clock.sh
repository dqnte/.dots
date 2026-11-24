#!/bin/bash

# big block-digit clock, a copy of tmux's clock-mode (<prefix> t)
#   -s     show seconds
#   -t     12-hour time with AM/PM
#   -c N   palette color slot 0-15 (default 4, blue like tmux)
# q, esc or ctrl-c quits

color=4
seconds=
twelve=
while getopts "stc:" opt; do
    case $opt in
        s) seconds=1 ;;
        t) twelve=1 ;;
        c) color=$OPTARG ;;
        *) exit 1 ;;
    esac
done

# palette slot as a background color, so the blocks follow the theme
if [ "$color" -lt 8 ]; then
    block="\033[4${color}m \033[0m"
else
    block="\033[10$((color - 8))m \033[0m"
fi
fg="\033[3$((color % 8))m"

# 5x5 glyphs from tmux's clock.c, one string per row
glyph() {
    case $1 in
        0) rows="11111 10001 10001 10001 11111" ;;
        1) rows="00001 00001 00001 00001 00001" ;;
        2) rows="11111 00001 11111 10000 11111" ;;
        3) rows="11111 00001 11111 00001 11111" ;;
        4) rows="10001 10001 11111 00001 00001" ;;
        5) rows="11111 10000 11111 00001 11111" ;;
        6) rows="11111 10000 11111 10001 11111" ;;
        7) rows="11111 00001 00001 00001 00001" ;;
        8) rows="11111 10001 11111 10001 11111" ;;
        9) rows="11111 10001 11111 00001 11111" ;;
        :) rows="00000 00100 00000 00100 00000" ;;
        A) rows="11111 10001 11111 10001 10001" ;;
        P) rows="11111 10001 11111 10000 10000" ;;
        M) rows="10001 11011 10101 10001 10001" ;;
        *) rows="00000 00000 00000 00000 00000" ;;
    esac
}

now() {
    fmt="%H:%M"
    [ -n "$twelve" ] && fmt="%l:%M"
    [ -n "$seconds" ] && fmt="$fmt:%S"
    [ -n "$twelve" ] && fmt="$fmt %p"
    date +"$fmt" | sed 's/^ //'
}

draw() {
    text=$1
    cols=$(tput cols)
    lines=$(tput lines)
    width=$((${#text} * 6 - 1))

    # only wipe the screen on resize or when the text changes length,
    # otherwise new frames overwrite the old one in place without flicker
    if [ -n "$dirty" ] || [ "${#text}" -ne "${#last}" ]; then
        printf '\033[2J'
        dirty=
    fi

    # too small for the big digits, fall back to plain text like tmux does
    if [ "$width" -gt "$cols" ] || [ "$lines" -lt 5 ]; then
        printf '\033[%d;%dH%b%s\033[0m' $((lines / 2 + 1)) $(((cols - ${#text}) / 2 + 1)) "$fg" "$text"
        return
    fi

    top=$(((lines - 5) / 2 + 1))
    left=$(((cols - width) / 2 + 1))
    for r in 0 1 2 3 4; do
        line=""
        i=0
        while [ $i -lt ${#text} ]; do
            glyph "${text:$i:1}"
            set -- $rows
            shift $r
            row=$1
            j=0
            while [ $j -lt 5 ]; do
                if [ "${row:$j:1}" = 1 ]; then line="$line$block"; else line="$line "; fi
                j=$((j + 1))
            done
            line="$line "
            i=$((i + 1))
        done
        printf '\033[%d;%dH%b' $((top + r)) "$left" "$line"
    done
}

cleanup() {
    printf '\033[0m\033[?25h\033[?1049l'
    stty echo 2>/dev/null
    exit 0
}

trap cleanup INT TERM EXIT
trap 'last=; dirty=1' WINCH

printf '\033[?1049h\033[?25l'
stty -echo 2>/dev/null

last=; dirty=1
while :; do
    text=$(now)
    if [ "$text" != "$last" ]; then
        draw "$text"
        last=$text
    fi
    # wait up to a second for a key, wakes early on resize
    if read -rsn1 -t 1 key 2>/dev/null; then
        case $key in
            q | Q | $'\e') cleanup ;;
        esac
    fi
done
