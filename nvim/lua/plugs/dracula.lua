Plug('dracula/vim', { name = 'dracula' })

vim.g.dracula_colorterm = 0
nvim_cmd("autocmd ColorScheme dracula set cursorline")
nvim_cmd("autocmd ColorScheme dracula highlight Cursorline ctermbg=233")
nvim_cmd("autocmd User PlugLoaded ++nested colorscheme dracula")
