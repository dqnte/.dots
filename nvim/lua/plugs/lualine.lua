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

	local fmt_mode = function(mode)
		if mode == "NORMAL" then
			return "Π"
		elseif mode == "INSERT" then
			return "Ψ"
		elseif mode == "COMMAND" then
			return "ξ"
		elseif mode == "VISUAL" or mode == "V-LINE" then
			return "Ω"
		end
		return mode
	end

	local fmt_progress = function(progress)
		if progress:len() < 4 and not (progress == "Top" or progress == "Bot") then
			return " " .. progress
		end
		return progress
	end

	require("lualine").setup({
		options = {
			theme = vim.luatheme == nil and vim.env.THEME or vim.luatheme,
			disabled_filetypes = { "markdown", "text", "alpha", "nerdtree" },
		},
		sections = {
			lualine_a = {
				{
					"mode",
					fmt = fmt_mode,
					separator = { left = " ", right = "" },
					padding = { left = 1, right = 2 },
				},
			},
			lualine_b = { fmt_head },
			lualine_c = {},
			lualine_x = { "diff" },
			lualine_y = {
				{
					"filetype",
					colored = false,
					icon_only = true,
					separator = { left = "", right = "" },
					padding = { left = 1, right = 0 },
				},

				{
					"filename",
					symbols = {
						modified = "●",
						readonly = "",
						unnamed = "[-]",
						newfile = "[+]",
					},
				},
			},
			lualine_z = {
				{
					"progress",
					fmt = fmt_progress,
					separator = { left = "", right = " " },
					padding = { left = 2, right = 1 },
				},
			},
		},
	})

	-- removes edges color styling
	hi("StatusLine guibg=none")
end
