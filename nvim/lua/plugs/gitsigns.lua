Plug("lewis6991/gitsigns.nvim")

vim.loaded.start_gitsigns = function()
	require("gitsigns").setup({
		current_line_blame = true,
		current_line_blame_opts = {
			virt_text_pos = "eol",
			and_something_here = "here",
		},
		on_attach = function()
			-- Navigation
			keymap("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
			keymap("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
			keymap("n", "<leader>gv", "<cmd>Gvdiff<CR>", { noremap = true, silent = true })
			keymap("n", "<leader>gh", "<cmd>Ghdiff<CR>", { noremap = true, silent = true })
		end,
	})
end
