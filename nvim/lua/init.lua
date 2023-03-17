vim.cmd("let &runtimepath.=','.escape(expand('~/.dots/nvim'), '\\,')")

local utils = require("utils")
pcall(require, "secrets")

utils.enable_lazy()

require("options")
require("colors/base")
require("display")
require("tools")
require("terminal")
require("filetypes")
require("langserver")

require("lazy").setup(vim.lazy_config)
