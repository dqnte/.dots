#!/bin/bash

# ALIASES
alias k=kubectl
alias v="nvim"
alias tclear='tmux kill-session -a'
alias pe='poetry run python'
alias pr='poetry run'
alias stay="caffeinate -d cmatrix"
alias clr=clear
alias x="xargs "

alias ls="lx"
alias g="git"
alias gs="sh ~/.dots/scripts/gs.sh -p"
alias gl="sh ~/.dots/scripts/gl.sh"
alias gb="sh ~/.dots/scripts/gb.sh"
alias ga="sh ~/.dots/scripts/ga.sh"
alias gr="sh ~/.dots/scripts/gr.sh"
alias gbk="sh ~/.dots/scripts/gbk.sh"
alias gch="gr | x g checkout"
alias grm="gr | x rm"
alias gcd='cd "$(gr | x dirname)"'
alias m="sh ~/.dots/scripts/m.sh"

alias gpop="git reset HEAD^"
alias z="source ~/.dots/scripts/z_ls.sh"
alias zr="source ~/.dots/scripts/zr.sh"
alias zrm="zr | x rm"

alias ff="sh ~/.dots/scripts/ff.sh"
alias fg="git ls-files --others --exclude-standard --modified | fzf | xargs nvim"

alias kitty-font="kitty --debug-font-fallback"

alias TODO="v ~/TODO.md"
alias NOTES="v ~/NOTES.md"
alias notes="cd ~/notes"
alias dots="cd ~/.dots"

# docker aliases
alias d="docker"
alias dup="docker-compose up -d --build"
alias ddown="docker-compose down"
alias dfollow="docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.CreatedAt}}\t{{.Ports}}' | tail -n +2 | fzf | awk '{print \$1}' | xargs docker logs --follow"

# key binding for kitty
bindkey '\e[1;3D' backward-word # ⌥←
bindkey '\e[1;3C' forward-word # ⌥→

# fixes backspace issues when sshing into a server
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="kitty +kitten ssh"
