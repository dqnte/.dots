vim.colorschemes["tokyonight"] = function()
    require("tokyonight").setup({
        style = "moon"
    })

    vim.cmd("colorscheme tokyonight")
end

lazy({
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {},
})
