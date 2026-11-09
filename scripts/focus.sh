#!/bin/bash
# Runs on Focus changes, called by Shortcuts automations: focus.sh day|night

exec >> "$HOME/Library/Logs/focus.log" 2>&1
echo "$(date '+%F %T') focus: $1"

# Shortcuts runs this without the shell env that theme.sh expects
export PATH="/Applications/cmux.app/Contents/Resources/bin:/opt/homebrew/bin:$PATH"
set -a
source "$HOME/.dots/.state"
set +a

case "$1" in
    day)
        bash "$HOME/.dots/scripts/theme.sh" light
        ;;
    night)
        bash "$HOME/.dots/scripts/theme.sh" dark
        ;;
    *)
        echo "usage: focus.sh day|night"
        exit 1
        ;;
esac
