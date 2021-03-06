Plug('fxn/vim-monochrome')

if (vim.env.THEME == 'monochrome') then
    vim.o.background = 'dark'
    vim.luatheme = "auto"
    vim.loaded.start_mono = function()
        vim.g.monochrome_italic_comments = 1
        nvim_cmd("colorscheme monochrome")
        nvim_cmd("highlight SignColumn ctermbg=0")
        nvim_cmd("highlight diffAdded guibg=none guifg=white")
        nvim_cmd("highlight GitSignsAdd ctermfg=4 guibg=none")
        nvim_cmd("highlight GitSignsChange ctermfg=5 guibg=none")
        nvim_cmd("highlight GitSignsDelete ctermfg=12 guibg=none")
    end
end
