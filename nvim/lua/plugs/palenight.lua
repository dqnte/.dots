Plug('drewtempelmeyer/palenight.vim')

if (vim.env.THEME == "palenight") then
    vim.o.background = "dark"
    vim.luatheme = "auto"
    vim.loaded.start_palenight = function()
        nvim_cmd("colorscheme palenight")
    end
end
