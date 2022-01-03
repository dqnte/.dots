Plug 'dense-analysis/ale' " linting pluggin
Plug 'sheerun/vim-polyglot' " langauge syntax highlighting

let g:ale_linters = {'python': ['flake8', 'mypy'], 'javascript': ['prettier', 'eslint']}
let g:ale_fixers = {'python': ['black', 'isort'], 'javascript': ['prettier', 'eslint']}
" let g:ale_fix_on_save = 1

autocmd BufWritePre * :%s/\s\+$//e " remove trailing white spaces
