Plug 'EdenEast/nightfox.nvim'

if (vim.env.THEME == 'nightfox') then
    vim.loaded.start_nightfox = function()
        require('nightfox').load()
    end
end
