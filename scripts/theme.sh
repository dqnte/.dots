#!/bin/bash
source ~/.dots/zsh/utils.sh

DEFAULT_THEME=everforest
THEMES_DIR="$HOME/.dots/ghostty/themes"

function show_all_themes() {
    themes_list=$(ls $THEMES_DIR | sed s/_light// | uniq)
    echo ""
    printf "  %s\n" $themes_list
    echo ""
}

function set_ghostty_theme() {
    file=$THEME
    [ "$THEME_MODE" = "light" ] && file="${THEME}_light"

    # some themes only have light variants
    if [ ! -f "$THEMES_DIR/$THEME" ]; then
        THEME_MODE="light"
        file="${THEME}_light"
    elif [ ! -f "$THEMES_DIR/$file" ]; then
        THEME_MODE="dark"
        file=$THEME
    fi

    cp "$THEMES_DIR/$file" ~/.dots/ghostty/theme
    cmux reload-config >/dev/null 2>&1
}

function set_cmux_theme() {
    source ~/.dots/zsh/fzf.sh

    cmux_settings="$HOME/.config/cmux/settings.json"
    tmp=$(mktemp)
    jq --arg color "$COLOR_POP_1" '.workspaceColors.selectionColor = $color' "$cmux_settings" > "$tmp" && mv "$tmp" "$cmux_settings"

    cmux reload-config >/dev/null 2>&1
}

function set_claude_theme() {
    file=$THEME
    [ "$THEME_MODE" = "light" ] && file="${THEME}_light"

    claude_themes="$HOME/.dots/claude/themes"
    claude_settings="$HOME/.claude/settings.json"

    # fall back to the built-in light/dark theme when there's no custom one
    theme="$THEME_MODE"
    [ -f "$claude_themes/$file.json" ] && theme="custom:$file"

    tmp=$(mktemp)
    jq --arg theme "$theme" '.theme = $theme' "$claude_settings" > "$tmp" && mv "$tmp" "$claude_settings"
}

function set_device_mode() {
    if [ $THEME_MODE = "dark" ]; then
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
    else
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
    fi
}

function change_theme() {
    file="${THEMES_DIR}/${1}"
    light_file="${THEMES_DIR}/${1}_light"

    if [ $1 = "dark" ] || [ $1 = "light" ]; then
        THEME_MODE="$1"
    elif [ -f "$file" ] || [ -f "$light_file" ]; then
        THEME=$1
    else
        echo -e "\n  \e[3mTheme not found\n\e[0m"
        exit 0
    fi

    set_ghostty_theme
    set_cmux_theme
    set_claude_theme

    # update zsh env
    set_state_value THEME $THEME
    set_state_value THEME_MODE $THEME_MODE
    killall -SIGUSR1 zsh

    # update nvim instances
    for path in $(nvr --nostart --serverlist); do
        nvr --servername $path --remote-send "<esc>:lua vim.g.update_colorscheme('$1')<enter>:<esc>"
    done

    set_device_mode
}

function picker() {
    choice=$(ls $THEMES_DIR | sed s/_light// | uniq | fzf)

    if [ ! -z "$choice" ]; then
        change_theme "$choice"
    fi
}

if [ -z $1 ]; then
    picker
elif [ "show" = $1 ]; then
    echo -e "\n  $THEME\n"
elif [ "show-all" = $1 ]; then
    show_all_themes
else
    change_theme $1
fi
