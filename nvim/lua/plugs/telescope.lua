Plug("nvim-telescope/telescope.nvim")

-- ripgrep required for live greping

keymap("n", "<leader>ff", "<cmd>lua vim.g.telescope_wrapper('find_files')<cr>", { noremap = true, silent = true })
keymap("n", "<leader>fb", "<cmd>lua vim.g.telescope_wrapper('buffers')<cr>", { noremap = true, silent = true })
keymap("n", "<leader>fg", "<cmd>lua vim.g.telescope_wrapper('live_grep')<cr>", { noremap = true, silent = true })
keymap("n", "<leader>gs", "<cmd>lua vim.g.telescope_wrapper('git_status')<cr>", { noremap = true, silent = true })

vim.g.get_flat = function(opts)
	opts = opts or {}

	require("nvim-web-devicons")

	local theme_opts = {
		theme = "flat",

		results_title = false,

		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		prompt_prefix = " ",
		selection_caret = "  ",
		layout_config = {
			preview_cutoff = 1,
			height = 60,
			prompt_position = "top",
		},

		border = true,
		borderchars = {
			prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
			results = { " ", " ", " ", " ", " ", " ", " ", " " },
			preview = { " ", " ", " ", " ", " ", " ", " ", " " },
		},
	}

	return vim.tbl_deep_extend("force", theme_opts, opts)
end

local set_custom_highlights = function()
	local get_color = require("utils").get_color
	local shift_color = require("utils").shift_color

	local prompt_bg = get_color("Folded", "bg#")
	local prompt_fg = get_color("Normal", "fg#")
	local bg_color = get_color("Normal", "bg#")
	local prompt_title = get_color("DiagnosticWarn", "fg#")

	local result_bg = shift_color(bg_color:gsub("#", ""), 3)
    if vim.o.background == "dark" then
		result_bg = shift_color(bg_color:gsub("#", ""), -3)
	end

	hi("TelescopePromptBorder guifg=" .. prompt_bg .. " guibg=" .. prompt_bg)
	hi("TelescopePromptNormal guibg=" .. prompt_bg .. " guifg=" .. prompt_fg)
	hi("TelescopePromptCounter guibg=" .. prompt_bg)

	hi("TelescopePromptTitle guifg=" .. prompt_bg .. " guibg=" .. prompt_title)
	hi("TelescopePromptPrefix guifg=" .. prompt_title .. " guibg=" .. prompt_bg)

	hi("TelescopeResultsBorder guifg=" .. result_bg .. " guibg=" .. result_bg)
	hi("TelescopePreviewBorder guifg=" .. result_bg .. " guibg=" .. result_bg)
	hi("TelescopePreviewTitle guifg=" .. result_bg .. " guibg=" .. result_bg)
	hi("TelescopeResultsNormal guibg=" .. result_bg)
	hi("TelescopeResultsNumber guibg=" .. result_bg)
	hi("TelescopeNormal guibg=" .. result_bg)
end

vim.g.telescope_wrapper = function(method)
	local layout_strategy = "horizontal"
	if vim.fn.winwidth("%") <= 90 then
		layout_strategy = "vertical"
	end

	set_custom_highlights()

	local caller = require("telescope.builtin")[method]
	caller(vim.g.get_flat({ layout_strategy = layout_strategy }))
end

vim.after.start_telescope = function()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			file_ignore_patterns = {
				"node_modules/",
				"__pycache__/",
				"modules/",
				".git/",
			},
			mappings = {
				i = {
					-- closes telescope on 1 escape press
					["<esc>"] = require("telescope.actions").close,
				},
			},
		},
	})
end
