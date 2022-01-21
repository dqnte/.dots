# zsh shape and colorization
setopt PROMPT_SUBST
parse_git_branch() {
   branch=$(git branch 2> /dev/null)
   branch=$(sed -e '/^[^*]/d' <<< $branch)
   branch=$(sed -e 's/* \(.*\)/\1/' <<< $branch)
   branch=$(sed -r 's/^[a-z]*-//' <<< $branch)
   branch=$(sed 's/^\([a-z]*-[0-9]*\).*/\1/' <<< $branch)
   if [ -z $branch ]
   then
      echo ""
   else
      echo "($branch) "
   fi
}

export PS1="\$(parse_git_branch)%1~ $ " # leading text in shell
export LSCOLORS=fxxxxxxxxxxxxxxxxxxxxx
alias ls="ls -G" # better ls colors

# changes cursor back to a beam on vim exit
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions=(_fix_cursor)
