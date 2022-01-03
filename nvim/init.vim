" Basic Settings
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching
set ignorecase              " case insensitive
set smartcase
set mouse=v                 " middle-click paste with
set hlsearch                " highlight search
set incsearch               " incremental search
set nohlsearch
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
set noswapfile              " disable creating swap file
set noshowmode

" Key Mappings"
map gf :edit <cfile><cr>

" Plugins
" Install vim plug if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
source ~/.dots/nvim/vim_fugitive.vim
source ~/.dots/nvim/vim_commentary.vim
source ~/.dots/nvim/dbext.vim
source ~/.dots/nvim/planerly.vim
source ~/.dots/nvim/getsigns.vim
source ~/.dots/nvim/dracufa.vim
source ~/.dots/nvim/vim_tmux_navigator.vim
source ~/.dots/nvim/lightline.vim
source ~/.dots/nvim/vim_startify.vim
source ~/.dots/nvim/telescope.vim
source ~/.dots/nvim/goyo.vim
source ~/.dots/nvim/linting.vim
call plug#end()

doautocmd User PlugLoaded
