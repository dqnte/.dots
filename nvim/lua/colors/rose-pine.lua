Plug('rose-pine/neovim')

if vim.env.THEME == "rose-pine" then
    vim.loaded.start_rosepine = function()
        vim.o.background = vim.env.THEME_MODE
        vim.cmd('colorscheme rose-pine')
    end
end
