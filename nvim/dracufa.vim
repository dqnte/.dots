Plug 'dracula/vim', {'name': 'dracula'}

let g:dracula_colorterm=0

augroup DraculaOverrides
    autocmd ColorScheme dracula set cursorline
    autocmd ColorScheme dracula highlight Cursorline ctermbg=233
    autocmd User PlugLoaded ++nested colorscheme dracula
augroup end
