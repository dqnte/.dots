#!/bin/bash

DOTDIR=$HOME/.dots
KITTYDIR=$DOTDIR/kitty
ZSHDIR=$DOTDIR/zsh
NVIMDIR=$DOTDIR/nvim

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

# add all config files
if [ ! -f $DOTDIR/.state ]; then
    touch $DOTDIR/.state
    echo "THEME=iceberg" >> $DOTDIR/.state
fi
[ ! -f $KITTYDIR/theme.conf ] && cp $KITTYDIR/dracula.conf $KITTYDIR/theme.conf
[ ! -f $NVIMDIR/lua/secrets.lua ] && touch $NVIMDIR/lua/secrets.lua

# build rust scripts
cd $DOTDIR/scripts/grrs
cargo build --release
cd $DOTDIR

# move scripts to /exe
cp $DOTDIR/scripts/theme.sh $DOTDIR/scripts/exe/theme
chmod u+x $DOTDIR/scripts/exe/theme
cp $DOTDIR/scripts/fancy_git $DOTDIR/scripts/exe/fgit
mv $DOTDIR/scripts/grrs/target/release/grrs $DOTDIR/scripts/exe/lx
cp $DOTDIR/scripts/font.sh $DOTDIR/scripts/exe/font
chmod u+x $DOTDIR/scripts/exe/font

# reload terminal
kill -SIGUSR1 $(pgrep kitty)
export THEME=iceberg
