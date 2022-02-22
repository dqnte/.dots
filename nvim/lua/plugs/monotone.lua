Plug('Lokaltog/vim-monotone')

if (vim.env.THEME == 'mono') then
    vim.o.background = 'dark'
    vim.o.termguicolors = false
    vim.luatheme = "auto"
    vim.loaded.start_mono = function()
        vim.g.monotone_emphasize_comments = 1
        nvim_cmd("colorscheme monotone")
        nvim_cmd("hi CursorLineNR ctermbg=234")
    end
end
