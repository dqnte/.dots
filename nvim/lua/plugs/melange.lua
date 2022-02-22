Plug("savq/melange", { name = "melange" })

if (vim.env.THEME == "melange") then
    vim.o.background = "dark"
    vim.luatheme = "auto"
    vim.loaded.start_melange = function()
        nvim_cmd("colorscheme melange")
    end
end
