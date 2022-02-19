Plug('dracula/vim', { name = 'dracula' })

if (vim.env.THEME == 'dracula') then
    vim.o.background = 'dark'
    vim.g.dracula_colorterm = 0
    nvim_cmd("autocmd ColorScheme dracula highlight Cursorline ctermbg=233")
    nvim_cmd("autocmd User PlugLoaded ++nested colorscheme dracula")
end
