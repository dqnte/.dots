Plug("nvim-lua/plenary.nvim")
Plug("tpope/vim-commentary")
Plug("tpope/vim-surround")
Plug("vim-scripts/dbext.vim")

-- benchmarking
Plug("dstein64/vim-startuptime")
Plug("lewis6991/impatient.nvim")

require("plugs/fugitive")
require("plugs/telescope")
require("plugs/hop")

-- keep highlight when indenting
keymap("v", "<", "<gv", { noremap = true })
keymap("v", ">", ">gv", { noremap = true })

-- aesthetic cli tools
user_command("Font", "!font <q-args>", { nargs = 1 })
user_command("Theme", "lua vim.g.set_colorscheme(<q-args>)", { nargs = 1 })

user_command("TODO", "e ~/TODO.md", {})

-- uses theme cli tool to flip colorscheme
vim.g.set_colorscheme = function(new_theme)
	vim.cmd("!theme " .. new_theme)
	vim.g.update_colorscheme(new_theme)
end

-- separate command for cli signal
vim.g.update_colorscheme = function(new_theme)
	if new_theme == "light" or new_theme == "dark" then
		vim.opt.background = new_theme
		vim.env.THEME_MODE = new_theme
	elseif vim.colorschemes[new_theme] ~= nil then
		vim.env.THEME = new_theme
	end

	vim.colorschemes[vim.env.THEME]()

	for _, caller in pairs(vim.after) do
		caller()
	end
end

-- format sql command
-- keymap('v', 'sf', "<cmd>'<,>'!sqlformat --reindent_aligned - <CR>", { noremap = true })

-- TODO: gf opens a new file if it doesn't exist
-- keymap("n", "gf", "<cmd>edit <cfile><CR>", { noremap = true, silent = true })
