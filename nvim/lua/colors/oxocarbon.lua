vim.colorschemes.oxocarbon = function()
	nvim_cmd("colorscheme oxocarbon")

    if vim.o.background == "light" then
        nvim_cmd("hi Comment guifg=#b3b3b3")
    end
end

lazy({ "nyoom-engineering/oxocarbon.nvim", priority = 100, config = require("utils").enable_colorscheme })

