
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
brew install git tmux nvim fzf nvr ripgrep jq sqlparse isort cmatrix
```

### Install Installers
```sh
brew install nvm pipx
pipx ensurepath
nvm install node
```

### Install Rust and Go

Rust
```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Go
You can download the installer from the website

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
npm install -g pyright
brew install mypy
pip install black flake8
```

Javascript
```sh
npm install -g eslint_d @fsouza/prettierd typescript-language-server typescript vscode-langservers-extracted
```

SCSS
```sh
npm i -g some-sass-language-server
```

Java

Install sdkman for package mgmt
```sh
curl -s "https://beta.sdkman.io" | bash
```

Kotlin
This is a weird one since it depends on what version of java you have running... I pulled from github
then followed the instructions to build it. Not sure if that's the right way. Here's the link:
```
https://github.com/fwcd/kotlin-language-server
```

```sh
brew install ktlint
```


### Font Configuration for Kitty
You may need to restart kitty after downloading fonts for them to appear.

You can download `Symbols Nerd Font` from your icloud.



Snap tool for window management
https://apps.apple.com/us/app/snap/id418073146?mt=12


### Database Tools

MongoDB
```sh
brew install mongosh
```

Postgres
```sh
brew doctor
brew update
brew install libpq
```
