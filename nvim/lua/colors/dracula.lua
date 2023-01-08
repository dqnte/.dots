Plug('dracula/vim', { name = 'dracula' })

if (vim.env.THEME == 'dracula') then
    vim.loaded.start_dracula = function()
        nvim_cmd("colorscheme dracula")
        nvim_cmd("hi Cursorline ctermbg=233 guibg=#22242e")
        nvim_cmd("hi CursorlineNR ctermbg=233 guibg=#22242e")
        nvim_cmd("hi Normal guibg=#15161c")
    end
end
