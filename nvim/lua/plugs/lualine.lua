Plug("nvim-lualine/lualine.nvim")

vim.after.start_lualine = function()
	local MAX_BRANCH_LEN = 35

	-- shortens long branch lengths
	local fmt_head = function()
		local head = vim.fn.FugitiveHead()
		if head:len() > MAX_BRANCH_LEN then
			return head:sub(1, MAX_BRANCH_LEN - 3) .. "..."
		else
			return head
		end
	end

	require("lualine").setup({
		options = {
			theme = vim.luatheme == nil and vim.env.THEME or vim.luatheme,
			disabled_filetypes = { "markdown", "text" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { fmt_head },
			lualine_c = {},
			lualine_x = { "diff" },
			lualine_y = { "filename" },
			lualine_z = { "progress" },
		},
	})
end
