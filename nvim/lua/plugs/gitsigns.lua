lazy({
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signs = {
				untracked = { text = "┊" },
			},
			current_line_blame = true,
			current_line_blame_opts = {
				virt_text_pos = "eol",
			},
			current_line_blame_formatter_opts = {
				relative_time = true,
			},
			on_attach = function()
				-- Navigation
				keymap("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
				keymap("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })
			end,
		})
	end,
})
