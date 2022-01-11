# Open tmux automatically
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~  tmux ]] && [ -z "$TMUX" ]; then
    exec tmux -f ~/.dots/tmux.conf
else
    source "$HOME/.dots/zsh/environment.sh"
    source "$HOME/.dots/zsh/aesthetic.sh"
    source "$HOME/.dots/zsh/utils.sh"
    source "$HOME/.dots/zsh/aliases.sh"

    # Pluggins
    zsh_add_plugin "lukechilds/zsh-nvm"
fi
