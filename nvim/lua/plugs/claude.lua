-- Inline ghost-text completion from Claude (replaces copilot.lua).
-- Needs ANTHROPIC_API_KEY in the environment; billed per token.
lazy({
	"milanglacier/minuet-ai.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("minuet").setup({
			provider = "claude",
			provider_options = {
				claude = {
					model = "claude-haiku-5-5",
					max_tokens = 256,
					-- haiku thinks by default, which eats max_tokens and returns no text
					optional = { thinking = { type = "disabled" } },
				},
			},
			-- never send .env files
			enable_predicates = {
				function()
					return not vim.fn.expand("%:t"):match("^%.env")
				end,
			},
			virtualtext = {
				auto_trigger_ft = { "*" },
				auto_trigger_ignore_ft = { "markdown" },
				keymap = {
					accept = "<M-l>",
					accept_line = "<M-L>",
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<M-e>",
				},
			},
		})
	end,
})
