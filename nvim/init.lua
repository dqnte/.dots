vim.cmd("let &runtimepath.=','.escape(expand('~/.dots/nvim'), '\\,')")

require "options"
require "mappings"

-- Plugins
Plug = vim.fn['plug#']
vim.loaded = {}

vim.call('plug#begin', '~/.dots/nvim/modules')
require "plugs.fugitive"
require "plugs.commentary"
require "plugs.sensible"
require "plugs.dbext"
require "plugs.planerly"
require "plugs.gitsigns"
require "plugs.dracula"
require "plugs.vim_tmux_navigator"
require "plugs.kitty"
require "plugs.lualine"
require "plugs.alpha"
require "plugs.telescope"
require "plugs.goyo"

-- All linting requirements
require "linting"
require "plugs.treesitter"
require "plugs.lspconfig"
require "plugs.lspsaga"
vim.call('plug#end')

vim.cmd("doautocmd User PlugLoaded")
for _, caller in pairs(vim.loaded) do
  caller()
end
