#!/bin/bash

DOTDIR=$HOME/.dots
KITTYDIR=$DOTDIR/kitty
ZSHDIR=$DOTDIR/zsh
NVIMDIR=$DOTDIR/nvim

if [ ! -d $DOTDIR/scripts/exe ]; then
    mkdir $DOTDIR/scripts/exe
fi

# removes flicker when opening a new terminal
touch $HOME/.hushlogin

# all these files need to be outside .dots so that zsh can see them
if [ ! -f $HOME/.zshenv ]; then
    ln -s $ZSHDIR/zshenv ~/.zshenv
fi

if [ ! -f $HOME/.zshrc ]; then
    ln -s $ZSHDIR/init.sh ~/.zshrc
fi

if [ ! -f $HOME/.config/kitty/kitty.conf ]; then
    ln -s $KITTYDIR/kitty.conf ~/.config/kitty/kitty.conf
fi

if [ ! -d $HOME/.config/nvim ]; then
    mkdir $HOME/.config/nvim
fi

if [ ! -f $HOME/.config/nvim/init.lua ]; then
    ln -s $NVIMDIR/lua/init.lua ~/.config/nvim/init.lua
fi

# add all config files
if [ ! -f $DOTDIR/.state ]; then
    touch $DOTDIR/.state
    echo "THEME=rose-pine" >> $DOTDIR/.state
    echo "THEME_MODE=dark" >> $DOTDIR/.state
fi
[ ! -f $KITTYDIR/theme.conf ] && cp $KITTYDIR/themes/rose-pine.conf $KITTYDIR/theme.conf
[ ! -f $NVIMDIR/lua/secrets.lua ] && touch $NVIMDIR/lua/secrets.lua

# build rust scripts
cd $DOTDIR/scripts/grrs
cargo build --release
cd $DOTDIR

# build go scripts
# You may need to install go from the website to do this
go build $DOTDIR/scripts/fancy_git.go

# move scripts to /exe
cp $DOTDIR/scripts/theme.sh $DOTDIR/scripts/exe/theme
chmod u+x $DOTDIR/scripts/exe/theme
mv $DOTDIR/fancy_git $DOTDIR/scripts/exe/fgit
mv $DOTDIR/scripts/grrs/target/release/grrs $DOTDIR/scripts/exe/lx
cp $DOTDIR/scripts/font.sh $DOTDIR/scripts/exe/font
chmod u+x $DOTDIR/scripts/exe/font

# reload terminal
kill -s USR1 $(pgrep kitty)
