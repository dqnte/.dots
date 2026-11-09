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
export PS1="%1d %F{8}::%f "

# export RPROMPT="%F{8}%~%f"

# changes cursor back to a beam on vim exit
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# ghost text showing what tab would complete; async so slow completers don't stall typing
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    ZSH_AUTOSUGGEST_STRATEGY=(completion)
    export ZSH_AUTOSUGGEST_USE_ASYNC=1
    export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
    export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
