Plug 'neovim/nvim-lspconfig'

vim.loaded.start_lsp = function()
    local LSP = require 'lspconfig'

    -- Lua server
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    local sumneko_root = os.getenv("HOME") .. "/.config/nvim/lua-language-server"
    local sumneko_bin = sumneko_root .. "/bin/lua-language-server"
    -- LSP.sumneko_lua.setup {
    --     cmd = { sumneko_bin, "-E", sumneko_root .. "/main.lua" },
    --     settings = {
    --         Lua = {
    --             runtime = {
    --                 version = 'LuaJIT',
    --                 path = runtime_path,
    --             },
    --             diagnostics = {
    --                 globals = {'vim'},
    --             },
    --             workspace = {
    --                 -- library = vim.api.nvim_get_runtime_file("", true),
    --                 checkThirdParty = false,
    --                 preloadFileSize = 1500,
    --             },
    --             telemetry = {
    --                 enable = false,
    --             },
    --         },
    --     },
    -- }
end

vim.loaded.start_lsp = start_lsp
