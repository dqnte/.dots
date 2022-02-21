Plug('dracula/vim', { name = 'dracula' })

if (vim.env.THEME == 'dracula') then
    vim.o.background = 'dark'
    vim.g.dracula_colorterm = 0

    vim.loaded.start_dracula = function()
        nvim_cmd("colorscheme dracula")
        nvim_cmd("hi Cursorline ctermbg=233 guibg=#121212")
        nvim_cmd("hi CursorlineNR ctermbg=233 guibg=#121212")
    end
end
