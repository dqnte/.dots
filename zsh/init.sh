#!/bin/bash

function set_zsh_env() {
    export DOTZSH="$HOME/.dots/zsh"
    source "$DOTZSH/utils.sh"
    source "$DOTZSH/environment.sh"
    source "$DOTZSH/aesthetic.sh"
    source "$DOTZSH/aliases.sh"
    source "$DOTZSH/completion.sh"
    source "$DOTZSH/fzf.sh"

    [ -f "$DOTZSH/secrets.sh" ] && source "$DOTZSH/secrets.sh"
}

set_zsh_env
