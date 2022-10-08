#!/bin/bash
PATH="$PATH:~/bin"

# Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# PSQL cli
export PATH="/usr/local/opt/postgresql@14/bin:$PATH"

# Python Setup
export PYENV_ROOT=/usr/local/var/pyenv
export PATH="$PYENV_ROOT/shims:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

# Lazy load pyenv
function pyenv() {
    unset -f pyenv
    eval "$(pyenv init - 2> null)"
    eval "$(pyenv virtualenv-init - 2> null)"
    [ ! -z $@  ] && pyenv $@
}

function pyclean() {
    find . -regex "\(.*__pycache__.*\|*.py[co]\)" -delete
}

# Go Setup
export GOPATH=$HOME/go-workspace # don't forget to change your path correctly!
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# Rust Setup
export PATH=$PATH:$HOME/.cargo/bin
