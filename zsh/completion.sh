#!/bin/bash

# style not showing up for some reason...
zstyle ':completion:*:*:git:*' script ~/.dots/zsh/functions/git-completions.bash

fpath=(~/.dots/zsh/functions $fpath)
autoload -U compinit && compinit
