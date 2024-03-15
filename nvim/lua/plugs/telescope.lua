keymap("n", "<leader>ff", "<cmd>lua vim.g.telescope_wrapper('find_files')<cr>", { noremap = true, silent = true })
keymap("n", "<leader>fb", "<cmd>lua vim.g.telescope_wrapper('buffers')<cr>", { noremap = true, silent = true })
keymap("n", "<leader>fg", "<cmd>lua vim.g.telescope_wrapper('live_grep')<cr>", { noremap = true, silent = true })
keymap("n", "<leader>gs", "<cmd>lua vim.g.telescope_wrapper('git_status')<cr>", { noremap = true, silent = true })
keymap("n", "<leader>gr", "<cmd>lua vim.g.telescope_wrapper('lsp_references')<cr>", { noremap = true, silent = true })

local get_flat = function(opts)
	opts = opts or {}

	local theme_opts = {
		theme = "flat",

		hidden = true, -- show hidden files
		preview_title = false,
		results_title = false,
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		prompt_prefix = "  ",
		selection_caret = "  ",

		layout_config = {
			preview_cutoff = 1,
			height = vim.fn.winheight("%") - 4,
			width = vim.fn.winwidth("%") - 10,
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

vim.g.telescope_wrapper = function(method)
	local layout_strategy = "horizontal"
	if vim.fn.winwidth("%") <= 150 then
		layout_strategy = "vertical"
	end

	local caller = require("telescope.builtin")[method]
	caller(get_flat({ layout_strategy = layout_strategy }))
end

local set_custom_highlights = function()
	-- if vim.g.colors_name == nil then
	--     return
	-- end

	local get_color = require("utils").get_color
	local shift_color = require("utils").shift_color

	local bg_color = get_color("Normal", "bg#")
	local fg_color = get_color("Normal", "fg#")
	local comment_color = get_color("Comment", "fg#")
	local bg_visual = get_color("CursorLine", "bg#")

	local prompt_bg = shift_color(bg_color:gsub("#", ""), -4)
	local result_bg = shift_color(bg_color:gsub("#", ""), 4)
	if vim.o.background == "dark" then
		prompt_bg = shift_color(bg_color:gsub("#", ""), 4)
		result_bg = shift_color(bg_color:gsub("#", ""), -4)
	end

	local prompt_title = get_color("Function", "fg#")

	hi("TelescopePromptBorder guifg=" .. prompt_bg .. " guibg=" .. prompt_bg)
	hi("TelescopePromptNormal guibg=" .. prompt_bg .. " guifg=" .. fg_color)
	hi("TelescopePromptTitle guifg=" .. prompt_bg .. " guibg=" .. prompt_title)
	hi("TelescopePromptCounter guibg=" .. prompt_bg .. " guifg=" .. comment_color)
	hi("TelescopePromptPrefix guifg=" .. prompt_title .. " guibg=" .. prompt_bg)

	hi("TelescopeResultsNormal guibg=" .. result_bg)
	hi("TelescopeResultsBorder guifg=" .. result_bg .. " guibg=" .. result_bg)

	hi("TelescopePreviewBorder guifg=" .. result_bg .. " guibg=" .. result_bg)
	hi("TelescopePreviewTitle guifg=" .. prompt_bg .. " guibg=" .. prompt_title)

	hi("TelescopeSelection guifg=" .. fg_color .. " guibg=" .. bg_visual)

	hi("TelescopeNormal guibg=" .. result_bg .. " guifg=" .. fg_color)
end

vim.after_colorscheme.telescope = function()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			file_ignore_patterns = {
				"node_modules/",
				"__pycache__/",
				"modules/",
				".git/",
                "grrs/",
                ".mypy_cache/",
                ".pytest_cache/",
                ".venv",
			},
			mappings = {
				i = {
					-- closes telescope on 1 escape press
					["<esc>"] = require("telescope.actions").close,

					-- these don't seem to work for some reason
					["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", type = "command" },
					["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", type = "command" },
				},
			},
		},
	})

	set_custom_highlights()
end

lazy({
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = vim.after_colorscheme.telescope,
})
