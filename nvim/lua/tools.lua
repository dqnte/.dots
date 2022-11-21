Plug("nvim-lua/plenary.nvim")
Plug("tpope/vim-commentary")
Plug("tpope/vim-surround")
Plug("vim-scripts/dbext.vim")

require("plugs/fugitive")
require("plugs/telescope")
require("plugs/hop")
require("plugs/nerdtree")

-- TODO: gf opens a new file if it doesn't exist
-- keymap("n", "gf", "<cmd>edit <cfile><CR>", { noremap = true, silent = true })
