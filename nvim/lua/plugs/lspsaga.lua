Plug 'glepnir/lspsaga.nvim'

local function start_saga()
    local saga = require('lspsaga')
    saga.init_lsp_saga()
end

vim.loaded.start_saga = start_saga
