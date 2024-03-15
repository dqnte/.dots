
### A New Machine
Install xcode stuff
```sh
xcode-select --install
```

Install Homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

### CLI Tools
```sh
brew install git tmux nvim fzf nvr ripgrep
```

### Build Custom CLI Tools
```sh
sh scripts/build.sh
```

### Neovim Language servers and formaters

Lua
```sh
brew install lua-language-server stylua
```

Python
```sh
brew install mypy
pip install black flake8 pyright
```

Javascript
```sh
brew install npm
npm install -g eslint_d @fsouza/prettierd typescript-language-server typescript
```

Kotlin

This is a weird one since it depends on what version of java you have running... I pulled from github
then followed the instructions to build it. Not sure if that's the right way. Here's the link:
```
https://github.com/fwcd/kotlin-language-server
```

### Font Configuration for Kitty
You may need to restart kitty after downloading fonts for them to appear



Snap tool for window management
https://apps.apple.com/us/app/snap/id418073146?mt=12
