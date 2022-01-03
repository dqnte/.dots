Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" you will also need to comment out a specific line in goyo because it
" overwrites specific styles on return exit
"
" execute 'colo '. get(g:, 'colors_name', 'default')

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_ctermfg=237
