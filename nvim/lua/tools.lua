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
keymap('v', '<', '<gv', { noremap = true })
keymap('v', '>', '>gv', { noremap = true })

-- format sql command
-- keymap('v', 'sf', "<cmd>'<,>'!sqlformat --reindent_aligned - <CR>", { noremap = true })

-- TODO: gf opens a new file if it doesn't exist
-- keymap("n", "gf", "<cmd>edit <cfile><CR>", { noremap = true, silent = true })
