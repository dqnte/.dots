vim.cmd("let &runtimepath.=','.escape(expand('~/.dots/nvim'), '\\,')")

require("utils")
pcall(require, "secrets")

-- instantiate hook tables
vim.loaded = {}
vim.after = {}

vim.call("plug#begin", "~/.dots/nvim/modules")
require("colors/base")
require("options")
require("display")
require("tools")
require("terminal")
require("filetypes")
require("langserver")
vim.call("plug#end")

-- Trigger loaded hooks
for _, caller in pairs(vim.loaded) do
	caller()
end

for _, caller in pairs(vim.after) do
	caller()
end
