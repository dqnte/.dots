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
			preview_config = {
				border = { "", "", "", "", "", "", "", " " },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				-- Navigation
				keymap("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
				keymap("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end
				-- Action
				map("n", "<leader>hs", gs.stage_hunk)
				map("n", "<leader>hr", gs.reset_hunk)
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("n", "<leader>hS", gs.stage_buffer)
				map("n", "<leader>hu", gs.undo_stage_hunk)
				map("n", "<leader>hR", gs.reset_buffer)
				map("n", "<leader>hp", gs.preview_hunk)
			end,
		})
	end,
})
