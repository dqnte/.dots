Plug('Shatur/neovim-ayu', { name = "ayu-nvim" })

if (vim.env.THEME == "ayu") then
    vim.o.background = "light"
    vim.loaded.start_ayu = function()
        require('ayu').colorscheme()
    end
end
