#!/bin/bash

# ALIASES
alias k=kubectl
alias gr='grep --exclude-dir=node_modules --exclude-dir=__pycache__ --exclude-dir=modules'
alias v=nvim
alias tclear='tmux kill-session -a'
alias pe='poetry run python'
alias theme="bash ~/.dots/scripts/theme.sh"
alias stay="caffeinate -d"
alias clr=clear

alias ls="bash ~/.dots/scripts/fancy_ls.sh"
alias g="~/.dots/scripts/fancy_git"
alias gs="g status"

# key binding for kitty
bindkey '\e[1;3D' backward-word # ⌥←
bindkey '\e[1;3C' forward-word # ⌥→

# fixes backspace issues when sshing into a server
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"
