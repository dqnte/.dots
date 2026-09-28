#!/bin/sh
# escape codes for the high contrast scripts used by monochrome themes
# only palette slots and default colors are used, never rgb, so text that is
# already on screen recolors when the terminal theme changes
#
# a theme listed in scripts/mono/themes needs its terminal theme files
# (ghostty/themes, kitty/themes) to provide
#   foreground  ink, the main text color
#   background  page
#   color 0     panel, a step lighter than the page, used for the name bands
#   color 2     mid gray, used for hashes, sizes, dates, and markers
#
#   ink      default foreground
#   mid      color 2
#   white    color 0 as a background
#   reverse  swaps the default colors for chips

ESC=$(printf '\033')

E_INK="$ESC[39m"
E_MID="$ESC[32m"
B_WHITE="$ESC[40m"
E_REVERSE="$ESC[7m"

E_BOLD="$ESC[1m"
E_ITALIC="$ESC[3m"
E_UNDERLINE="$ESC[4m"
E_STRIKE="$ESC[9m"
# drops weight and decoration but keeps the band underneath
E_ATTRS_OFF="$ESC[22;23;24;29m"
E_RESET="$ESC[0m"
