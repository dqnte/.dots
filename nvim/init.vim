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
" set cc=80                  " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
set noswapfile            " disable creating swap file
set noshowmode

" Vim-plug
call plug#begin('~/.vim/plugged')
" Core plugins
Plug 'tpope/vim-fugitive' " fancy git command integrations
Plug 'tpope/vim-commentary' " fancy commenting
Plug 'vim-scripts/dbext.vim' " database integrations
Plug 'nvim-lua/plenary.nvim' " required by some packages
Plug 'lewis6991/gitsigns.nvim' " git history viewer on file
Plug 'dracula/vim', {'name': 'dracula'} " color pallette
Plug 'christoomey/vim-tmux-navigator' " move between vim and tmux easily
Plug 'itchyny/lightline.vim' " insert and git info at bottom of nvim
Plug 'mhinz/vim-startify' " startup screen

" Linting plugins
Plug 'dense-analysis/ale' " linting pluggin
Plug 'sheerun/vim-polyglot' " langauge syntax highlighting

" Telescope plugin for fuzzy string searches
Plug 'nvim-telescope/telescope.nvim'
" An optional plugin recommended by Telescope docs
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make' }

" Focus mode
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
call plug#end()

" Color Scheme
set background=dark
let g:dracula_colorterm=0
colorscheme dracula

" Goyo settings
function! ExitGoyo()
    Limelight! " exit limelight when goyo exits
endfunction

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave :call ExitGoyo()
let g:limelight_conceal_ctermfg=237

" startify
let g:startify_bookmarks = [
      \ {'a':'~/.dots/.zshrc'},
      \ {'s':'~/.dots/init.vim'},
      \ {'d':'~/.dots/.tmux.conf'}
      \ ]

let g:startify_custom_header = ['']
" autocmd User Startified Goyo
" autocmd User Startified Limelight!

" highlight current cursorline + set line color
set cursorline
highlight CursorLine ctermbg=233

" bottom bar information
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" Linting
let g:ale_linters = {'python': ['flake8', 'mypy'], 'javascript': ['prettier', 'eslint']}
let g:ale_fixers = {'python': ['black', 'isort'], 'javascript': ['prettier', 'eslint']}
" let g:ale_fix_on_save = 1

autocmd BufWritePre * :%s/\s\+$//e " remove trailing white spaces

" tmux movement integreation for vim "
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" telescope key bindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" lua require('plugs/telescope')
" lua require('plugs/gitsigns')

source ~/.dots/nvim/dbext.vim
