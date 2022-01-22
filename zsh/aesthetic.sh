# zsh shape and colorization
setopt PROMPT_SUBST
parse_git() {
   branch=$(git branch --show-current 2> /dev/null | cut -d '-' -f 2-3)
   if [ $branch ]
   then
      echo "%F{blue}($branch)%f "
   fi
}

parse_venv() {
   if [[ $PATH == *"pyenv-virtualenv"* ]]
   then
      echo "%F{blue}%f "
   fi
}

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PS1="\$(parse_venv)\$(parse_git)%1~ $ " # leading text in shell
export LSCOLORS=cxxxxxxxxxxxxxxxxxxxxx
alias ls="ls -G" # better ls colors

# changes cursor back to a beam on vim exit
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions=(_fix_cursor)
