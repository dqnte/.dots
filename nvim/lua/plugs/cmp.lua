Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-buffer")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-cmdline")
Plug("hrsh7th/nvim-cmp")

-- vsnip
Plug("hrsh7th/cmp-vsnip")
Plug("hrsh7th/vim-vsnip")

vim.loaded.start_cmp = function()
	local cmp = require("cmp")
	cmp.setup({
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body)
			end,
		},
		window = {},
		mapping = cmp.mapping.preset.insert({
			["<Tab>"] = cmp.mapping.confirm({ select = true }),
		}),
		sources = cmp.config.sources({
            -- in order of priority
			{ name = "buffer", max_item_count = 2 },
			{ name = "nvim_lsp", max_item_count = 2 },
		}),
	})
end
