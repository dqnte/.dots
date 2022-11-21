Plug('drewtempelmeyer/palenight.vim')

if (vim.env.THEME == "palenight") then
    vim.o.background = "dark"
    vim.luatheme = "auto"
    vim.loaded.start_palenight = function()
        nvim_cmd("colorscheme palenight")
        nvim_cmd("hi Normal guibg=#181a24")
        nvim_cmd("hi Cursorline guibg=#1f2430")
        nvim_cmd("hi Comment gui=italic")
    end
end
