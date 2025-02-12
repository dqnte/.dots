#!/bin/zsh

export THEME="$( get_state_value "THEME=" )"
export THEME_MODE="$( get_state_value "THEME_MODE=" )"
export FONT="$( get_state_value "FONT=" )"

# zsh prompt styles
setopt PROMPT_SUBST
function parse_git() {
   branch=$(git branch --show-current 2> /dev/null | cut -d '/' -f 2-3)
   if [ $branch ]; then
       num_files=$(git status --porcelain | wc -l | xargs)
       if [ $num_files -gt 0 ]; then
           num_files="%F{8}~$num_files%f"
       else
           num_files="%F{8}--%f"
       fi
       echo "%B$branch%b $num_files"
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
# export PS1="%1~ \$(parse_venv) "
export PS1="%1~ -> "
export RPROMPT="\$(parse_git)"

# changes cursor back to a beam on vim exit
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions=(_fix_cursor)
