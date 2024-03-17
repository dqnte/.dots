local dropdown_fmt = function(entry, vim_item)
	local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
	local strings = vim.split(kind.kind, "%s", { trimempty = true })

	if strings[1] == "TabNine" then
		kind.kind = " "
	else
		kind.kind = " " .. strings[1]
	end
	return kind
end

lazy({
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",

		-- vsnip
		-- "hrsh7th/cmp-vsnip",
		-- "hrsh7th/vim-vsnip",

		-- luasnip
		{
			"L3MON4D3/Luasnip",
			version = "v2.*",
		},
		"saadparwaiz1/cmp_luasnip",
		-- "rafamadriz/friendly-snippets",

		-- pretty formatting
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = cmp.config.sources({
				-- in order of priority
				-- { name = "luasnip", max_item_count = 2 },
				-- { name = "buffer", max_item_count = 2 },
				-- { name = "nvim_lsp", max_item_count = 3 },
			}),
			formatting = {
				-- only display the kind icon and not the text
				format = dropdown_fmt,
				fields = { "abbr", "kind" },
			},
			experimental = {
				ghost_text = true,
			},
		})
	end,
})

-- Took this from:
-- https://www.reddit.com/r/neovim/comments/14efftl/whats_your_copilot_setup/
lazy({
	"zbirenbaum/copilot.lua",
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	cmd = "Copilot",
	build = ":Copilot auth",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = true,
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<Tab>",
					reject = "<S-Tab>",
				},
			},
		})

		-- hide copilot suggestions when cmp menu is open
		-- to prevent odd behavior/garbled up suggestions
		local cmp_status_ok, cmp = pcall(require, "cmp")
		if cmp_status_ok then
			cmp.event:on("menu_opened", function()
				vim.b.copilot_suggestion_hidden = true
			end)

			cmp.event:on("menu_closed", function()
				vim.b.copilot_suggestion_hidden = false
			end)
		end
	end,
})
