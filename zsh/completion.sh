#!/bin/zsh
autoload -Uz compinit && compinit

# kubectl completion
source $DOTZSH/functions/kubectl-completions.sh
compdef __start_kubectl k # maps completion to alias
