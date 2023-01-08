Plug('arcticicestudio/nord-vim')

if vim.env.THEME == "nord" then
    vim.loaded.start_nord = function()
        nvim_cmd("colorscheme nord")
    end
end
