vim.cmd("let &runtimepath.=','.escape(expand('~/.dots/nvim'), '\\,')")

require("utils")
pcall(require, "secrets")

-- instantiate hook tables
vim.colorschemes = {}
vim.loaded = {}
vim.after = {}

vim.call("plug#begin", "~/.dots/nvim/modules")
pcall(require, "colors/base")
pcall(require, "options")
pcall(require, "display")
pcall(require, "tools")
pcall(require, "terminal")
pcall(require, "filetypes")
pcall(require, "langserver")
vim.call("plug#end")

-- Trigger loaded hooks
for _, caller in pairs(vim.loaded) do
	pcall(caller)
end

vim.colorschemes[vim.env.THEME]()

for _, caller in pairs(vim.after) do
	pcall(caller)
end
