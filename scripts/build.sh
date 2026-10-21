#!/bin/bash

DOTDIR=$HOME/.dots
GHOSTTYDIR=$DOTDIR/ghostty
CMUXDIR=$DOTDIR/cmux
ZSHDIR=$DOTDIR/zsh
NVIMDIR=$DOTDIR/nvim
CLAUDEDIR=$DOTDIR/claude

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

if [ ! -f $HOME/.config/ghostty/config ]; then
    mkdir -p $HOME/.config/ghostty
    ln -s $GHOSTTYDIR/config ~/.config/ghostty/config
fi

if [ ! -f $HOME/.config/cmux/cmux.json ]; then
    mkdir -p $HOME/.config/cmux
    ln -s $CMUXDIR/cmux.json ~/.config/cmux/cmux.json
fi

if [ ! -d $HOME/.config/nvim ]; then
    mkdir -p $HOME/.config/nvim
fi

if [ ! -f $HOME/.config/nvim/init.lua ]; then
    ln -s $NVIMDIR/lua/init.lua ~/.config/nvim/init.lua
fi

if [ ! -e $HOME/.claude/themes ]; then
    mkdir -p $HOME/.claude
    ln -s $CLAUDEDIR/themes ~/.claude/themes
fi

# add all config files
if [ ! -f $DOTDIR/.state ]; then
    touch $DOTDIR/.state
    echo "THEME=rose-pine" >> $DOTDIR/.state
    echo "THEME_MODE=dark" >> $DOTDIR/.state
fi
[ ! -f $GHOSTTYDIR/theme ] && cp $GHOSTTYDIR/themes/rose-pine $GHOSTTYDIR/theme
[ ! -f $NVIMDIR/lua/secrets.lua ] && touch $NVIMDIR/lua/secrets.lua

# macOS System Settings
sh $DOTDIR/mac/macos.sh

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
