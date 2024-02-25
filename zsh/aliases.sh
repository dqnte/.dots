#!/bin/bash

# ALIASES
alias k=kubectl
alias gr='grep --exclude-dir=node_modules --exclude-dir=__pycache__ --exclude-dir=modules'
alias v="nvim"
alias tclear='tmux kill-session -a'
alias pe='poetry run python'
alias stay="caffeinate -d"
alias clr=clear

alias ls="lx"
alias g="git"
alias gs="sh ~/.dots/scripts/gs.sh -p"
alias gl="fgit log"
alias gb="sh ~/.dots/scripts/gb.sh"
alias ga="sh ~/.dots/scripts/ga.sh"
alias gbk="git checkout -"

alias gpop="git reset HEAD^"
alias z="source ~/.dots/scripts/z_ls.sh"

alias ff="find * -type f -not -path '*node_modules/*' | fzf | xargs nvim"
alias fg="git ls-files --others --exclude-standard --modified | fzf | xargs nvim"

alias kitty-font="kitty --debug-font-fallback"

alias TODO="v ~/TODO.md"
alias NOTES="v ~/NOTES.md"
alias dots="cd ~/.dots"

# key binding for kitty
bindkey '\e[1;3D' backward-word # ⌥←
bindkey '\e[1;3C' forward-word # ⌥→

# fixes backspace issues when sshing into a server
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"
