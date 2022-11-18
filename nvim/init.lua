vim.cmd("let &runtimepath.=','.escape(expand('~/.dots/nvim'), '\\,')")

require("utils")
require("mappings")
require("options")
pcall(require, "secrets")

-- Plugins
Plug = vim.fn["plug#"]
vim.loaded = {}
vim.after = {}

vim.call("plug#begin", "~/.dots/nvim/modules")
-- Color Schemes
require("plugs.dracula")
require("plugs.ayu")
require("plugs.monochrome")
require("plugs.monotone")
require("plugs.melange")
require("plugs.palenight")
require("plugs.horizon")
require("plugs.iceberg")

-- Plugins
require("plugs.fugitive")
require("plugs.commentary")
require("plugs.sensible")
require("plugs.dbext")
require("plugs.planerly")
require("plugs.gitsigns")
require("plugs.vim_tmux_navigator")
require("plugs.kitty")
require("plugs.lualine")
require("plugs.alpha")
require("plugs.telescope")
require("plugs.nerdtree")
require("plugs.goyo")
require("plugs.hop")
require("plugs.vue")

-- All linting requirements
require("linting")
require("plugs.treesitter")
require("plugs.lspconfig")
require("plugs.null_ls")
require("plugs.cmp")
vim.call("plug#end")

vim.cmd("doautocmd User PlugLoaded")
for _, caller in pairs(vim.loaded) do
	caller()
end

vim.after.start_hop()
