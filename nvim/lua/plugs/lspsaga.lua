Plug 'glepnir/lspsaga.nvim'

vim.loaded.start_saga = function()
    local saga = require('lspsaga')
    saga.init_lsp_saga()
end
