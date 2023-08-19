#!/bin/bash

# ALIASES
alias k=kubectl
alias gr='grep --exclude-dir=node_modules --exclude-dir=__pycache__ --exclude-dir=modules'
alias v="nvim -u ~/.dots/nvim/lua/init.lua"
alias tclear='tmux kill-session -a'
alias pe='poetry run python'
alias stay="caffeinate -d"
alias clr=clear

alias ls="lx"
alias g="git"
alias gs="fgit status"
alias gl="fgit log"
alias gb="fgit branch"
alias gbk="git checkout -"

alias kitty-font="kitty --debug-font-fallback"

alias TODO="v ~/TODO.md"
alias NOTES="v ~/NOTES.md"
alias dots="cd ~/.dots"

# key binding for kitty
bindkey '\e[1;3D' backward-word # ⌥←
bindkey '\e[1;3C' forward-word # ⌥→

# fixes backspace issues when sshing into a server
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"
