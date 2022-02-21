Plug('dracula/vim', { name = 'dracula' })

if (vim.env.THEME == 'dracula') then
    vim.o.background = 'dark'
    vim.g.dracula_colorterm = 0

    local drac_highlight = "autocmd ColorScheme dracula highlight "
    nvim_cmd(drac_highlight .. "Cursorline ctermbg=233")
    nvim_cmd(drac_highlight .. "CursorlineNR ctermbg=233 cterm=none")
    nvim_cmd("autocmd User PlugLoaded ++nested colorscheme dracula")
end
