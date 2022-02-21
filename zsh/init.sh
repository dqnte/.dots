#!/bin/bash
AUTO_TMUX=true

function set_zsh_env() {
    DOTZSH="$HOME/.dots/zsh"
    source "$DOTZSH/utils.sh"
    source "$DOTZSH/environment.sh"
    source "$DOTZSH/aesthetic.sh"
    source "$DOTZSH/aliases.sh"
    source "$DOTZSH/completion.sh"

    # Pluggins
    zsh_add_plugin "lukechilds/zsh-nvm"
}

function boot_up() {
    # Open tmux automatically
    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~  tmux ]] && [ -z "$TMUX" ] && [ $AUTO_TMUX ]
    then
        export TERM=screen-256color # for italics in tmux
        exec tmux -f ~/.dots/tmux.conf
    else
        set_zsh_env
    fi
}

boot_up
