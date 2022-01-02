PATH=$PATH:~/bin

# Load NVM - removded because of lazy loading with oh-my-zsh
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

export PATH="$HOME/.poetry/bin:$PATH" # poetry cli
export PATH="/usr/local/opt/postgresql@11/bin:$PATH" # psql cli

# Python Setup
export PYENV_ROOT=/usr/local/var/pyenv
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

# Lazy load pyenv - gotta work on it tho
function pyenv() {
    unset -f pyenv
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    pyenv $@
}

function pe() {
    unset -f pe
    pyenv local
    alias pe='poetry run python'
    echo 'pyenv set, rerun pe'
}

function pyclean() {
    find . -regex "\(.*__pycache__.*\|*.py[co]\)" -delete
}

# oh my zsh
plugins=(kubectl)
export ZSH="$HOME/.oh-my-zsh"

# nvm lazy loading
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
plugins+=(zsh-nvm)

source $ZSH/oh-my-zsh.sh

# ALIASES
alias k=kubectl
alias ol='cd ~/onelogin; onelogin-aws-assume-role --onelogin-password $(security find-generic-password -s onelogin -w) --profile default; cd $OLDPWD'
alias g='grep --exclude-dir=node_modules --exclude-dir=__pycache__'
alias v=nvim
alias sft='sqlformat --reindent_aligned -' # need to add -i in vim


# Open tmux automatically
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
