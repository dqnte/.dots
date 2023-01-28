Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")

-- vsnip
-- Plug("hrsh7th/cmp-vsnip")
-- Plug("hrsh7th/vim-vsnip")

-- luasnip
Plug("L3MON4D3/Luasnip")
Plug("saadparwaiz1/cmp_luasnip")
Plug("rafamadriz/friendly-snippets")

-- pretty formatting
Plug("onsails/lspkind.nvim")

vim.loaded.start_cmp = function()
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
			{ name = "luasnip", max_item_count = 2 },
			{ name = "buffer", max_item_count = 2 },
			{ name = "nvim_lsp", max_item_count = 3 },
		}),
		formatting = {
			-- only display the kind icon and not the text
			format = function(entry, vim_item)
				local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
				local strings = vim.split(kind.kind, "%s", { trimempty = true })
				kind.kind = " " .. strings[1]
				return kind
			end,
			fields = { "abbr", "kind" },
		},
		experimental = {
			ghost_text = false,
		},
	})
end
