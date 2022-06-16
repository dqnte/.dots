Plug("ntk148v/vim-horizon", { name = "horizon" })

if (vim.env.THEME == "horizon") then
    vim.o.background = "dark"
    vim.luatheme = "auto"
    vim.loaded.start_horizon = function()
        nvim_cmd("colorscheme horizon")
        nvim_cmd("hi GitSignsCurrentLineBlame guifg=#6c6f93 guibg=#2e303e")
    end
end
