Plug("folke/zen-mode.nvim")

vim.loaded.start_zen = function()
	require("zen-mode").setup({
		window = {
			backdrop = 0.95,
		},

		on_open = function()
			vim.opt.signcolumn = "yes:2"
            vim.cmd("Gitsigns detach")
            vim.g.in_zen = true
		end,
		on_close = function()
			vim.opt.signcolumn = "yes"
            vim.cmd("Gitsigns attach")
            vim.g.in_zen = false
		end,
	})

    vim.g.in_zen = false
    user_command("Z", "ZenMode", {})
end
