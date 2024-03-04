vim.after_colorscheme.hop = function()
	require("hop").setup()

	-- keyboard shortcuts
	keymap("n", "<leader>e", "<cmd> HopWord<cr>", {})
	keymap("v", "<leader>e", "<cmd> HopWord<cr>", {})

	-- keymap for word end jump
	local lua_require = "<cmd> lua require'hop'.hint_words"
	local props = "({ hint_position = require'hop.hint'.HintPosition.END })"
	keymap("n", "<leader>w", lua_require .. props .. "<cr>", {})
	props = "({ hint_position = require'hop.hint'.HintPosition.END })"
	keymap("v", "<leader>w", lua_require .. props .. "<cr>", {})

	-- check terminal color is defined
	if vim.g["terminal_color_1"] then
		nvim_cmd("hi default link HopUnmatched Comment")
		nvim_cmd("hi HopNextKey gui=bold guifg=" .. vim.g.terminal_color_1 .. " guibg=none")
		nvim_cmd("hi HopNextKey1 gui=bold guifg=" .. vim.g.terminal_color_3 .. " guibg=none")
		nvim_cmd("hi HopNextKey2 guifg=" .. vim.g.terminal_color_3 .. " guibg=none")
	end
end

lazy({
	"phaazon/hop.nvim",
	config = vim.after_colorscheme.hop,
})
