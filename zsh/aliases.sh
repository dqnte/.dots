# ALIASES
alias k=kubectl
alias ol='cd ~/onelogin; onelogin-aws-assume-role --onelogin-password $(security find-generic-password -s onelogin -w) --profile default; cd $OLDPWD'
alias g='grep --exclude-dir=node_modules --exclude-dir=__pycache__ --exclude-dir=modules'
alias v=nvim
alias tclear='tmux kill-session -a'
alias pe='poetry run python'