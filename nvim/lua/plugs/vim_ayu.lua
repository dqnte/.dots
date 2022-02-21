Plug('Shatur/neovim-ayu', { name = 'ayu' })

if (vim.env.THEME == 'ayu') then
    vim.o.background = 'light'
    vim.loaded.start_ayu = function()
        require('ayu').colorscheme()
        nvim_cmd("highlight Cursorline guibg=#eeeeee")
        nvim_cmd("highlight GitSignsCurrentLineBlame guifg=#a8a8a8")
    end
end
