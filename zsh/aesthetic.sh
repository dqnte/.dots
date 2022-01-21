# zsh shape and colorization
setopt PROMPT_SUBST
parse_git_branch() {
   branch=$(git branch 2> /dev/null)
   branch=$(sed -e '/^[^*]/d' <<< $branch)
   branch=$(sed -e 's/* \(.*\)/\1/' <<< $branch)
   branch=$(sed -r 's/^[a-z]*-//' <<< $branch) # remove initials
   branch=$(sed 's/^\([a-z]*-[0-9]*\).*/\1/' <<< $branch) # show ticket
   if [ -z $branch ]
   then
      echo ""
   else
      echo "%F{blue}($branch)%f "
   fi
}

export PS1="\$(parse_git_branch)%1~ $ " # leading text in shell
export LSCOLORS=cxxxxxxxxxxxxxxxxxxxxx
alias ls="ls -G" # better ls colors

# changes cursor back to a beam on vim exit
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions=(_fix_cursor)
