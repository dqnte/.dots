#!/bin/zsh
autoload -Uz compinit && compinit

# style not showing up for some reason...
zstyle ':completion:*:*:git:*' script $DOTZSH/functions/git-completions.bash
fpath=(~/.dots/zsh/functions $fpath)

# kubectl completion
source $DOTZSH/functions/kubectl-completions.sh
compdef __start_kubectl k # maps completion to alias
