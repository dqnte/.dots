#!/bin/bash
PATH="$PATH:~/bin"

# Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# PSQL cli
export PATH="$PATH:/usr/local/opt/postgresql@14/bin"
export PATH="$PATH:/opt/homebrew/opt/libpq/bin"

# Python Setup
export PATH="$PATH:$HOME/Library/Python/3.9/bin"
PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="$HOME/.poetry/bin:$PATH"

# Lazy load pyenv
function pyenv() {
    unset -f pyenv
    eval "$(pyenv init - 2> /dev/null)"
    eval "$(pyenv virtualenv-init - 2> /dev/null)"
    [ ! -z $@  ] && pyenv $@
}

function pyclean() {
    find . -regex "\(.*__pycache__.*\|*.py[co]\)" -delete
}

function poetry_clean() {
    # Cleans out files installed by poetry in current env
    POETRY_LOCATION=`poetry env info -p`

    if [ ! -z $POETRY_LOCATION ]; then
        echo -e "\n  Poetry is $POETRY_LOCATION\n"
        rm -rf "$POETRY_LOCATION"
    else
        echo -e "\n No poetry environment found\n"
    fi
}

# Go Setup
export GOPATH=$HOME/go-workspace # don't forget to change your path correctly!
# export GOROOT=/usr/local/opt/go/libexec This was on the intel mac, maybe they install in different places?
export GOROOT=/usr/local/go
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"

# Rust Setup
export PATH="$PATH:$HOME/.cargo/bin"

# Java Setup
export JAVA_HOME="/opt/homebrew/opt/openjdk/bin/java"

# Node and friends
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

export PNPM_HOME="/Users/dtobar/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PATH:$PNPM_HOME" ;;
esac

# scripts
export PATH="$PATH:$HOME/.dots/scripts/exe"
