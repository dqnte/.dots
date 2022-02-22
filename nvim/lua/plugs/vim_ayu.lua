Plug('Shatur/neovim-ayu', {name = "ayu"})

if (vim.env.THEME:find('ayu')) then
    if (vim.env.THEME == "ayu-light") then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end
    vim.luatheme = "ayu"
    vim.loaded.start_ayu = function()
        require('ayu').colorscheme()
    end
end
