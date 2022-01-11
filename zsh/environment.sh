PATH="$PATH:~/bin"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export PATH="$HOME/.poetry/bin:$PATH" # poetry cli
export PATH="/usr/local/opt/postgresql@11/bin:$PATH" # psql cli

# Python Setup
export PYENV_ROOT=/usr/local/var/pyenv

# Lazy load pyenv - gotta work on it tho
function pyenv() {
    unset -f pyenv
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    pyenv $@
}

function pyclean() {
    find . -regex "\(.*__pycache__.*\|*.py[co]\)" -delete
}
