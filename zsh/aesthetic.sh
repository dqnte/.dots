# zsh shape and colorization
setopt PROMPT_SUBST
parse_git() {
   branch=$(git branch --show-current 2> /dev/null | cut -d '-' -f 2-3)
   if [ $branch ]
   then
      echo "($branch) "
   fi
}

parse_venv() {
   if [[ $PATH == *"pyenv-virtualenv"* ]]
   then
      echo "+>"
   else
      echo ">"
   fi
}

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PS1="%F{blue}\$(parse_git)%f%1~ \$(parse_venv) "
export LSCOLORS=cxxxxxxxxxxxxxxxxxxxxx
alias ls="ls -G" # better ls colors

# changes cursor back to a beam on vim exit
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions=(_fix_cursor)
