# zsh shape and colorization
export PS1="%1~ $ " # leading text in shell

export CLICOLOR=1
export LSCOLORS=fxxxxxxxxxxxxxxxxxxxxx

alias ls="ls -G" # better ls colors

# changes cursor back to a beam on vim exit
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions=(_fix_cursor)
