#!/bin/zsh

export THEME="$( get_state_value "THEME=" )"
export THEME_MODE="$( get_state_value "THEME_MODE=" )"

# zsh prompt styles
setopt PROMPT_SUBST
function parse_git() {
   branch=$(git branch --show-current 2> /dev/null | cut -d '-' -f 2-3)
   if [ $branch ]; then
      echo "($branch) "
   fi
}

function parse_venv() {
   if [[ $PATH == *"pyenv-virtualenv"* ]]; then
      echo "=>"
   else
      echo "->"
   fi
}

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
# export PS1="%F{blue}\$(parse_git)%f%1~ \$(parse_venv) "
export PS1="%1~ \$(parse_venv) "
export LSCOLORS=cxxxxxxxdxxxxxxxxxxxxx
alias ls="ls -G" # better ls colors

# changes cursor back to a beam on vim exit
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions=(_fix_cursor)
