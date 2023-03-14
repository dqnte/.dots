Install nvim

Add a source file to your .zshrc
`source ~/.dots/zsh/init.sh`

If you are running kitty you will need to add the following line to your kitty config:
`include ~/.dots/kitty/kitty.conf`

Run `prefix + I` in terminal to install tmux files

If italics is not enabled in `tmux`, you will need to run this command:
`tic zsh/functions/screen-256color.terminfo`

Remember, you will need to run `:PlugInstall` the first time you boot up nvim

Also make sure homebrew is updated, `brew update; brew upgrade`

You will new to install `ripgrep` to use Telescope's live grepping tool
`brew install ripgrep`

Download and install Fira Code Font using homebre:
`brew tab homebrew/cask-fonts; brew install --cask font-fira-code`

Download and install the Symbols from here [https://github.com/ryanoasis/nerd-fonts/blob/master/src/glyphs/Symbols-2048-em%20Nerd%20Font%20Complete.ttf]
