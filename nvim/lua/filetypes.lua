-- JS/TS
vim.cmd([[autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab]])
vim.cmd([[autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab]])
vim.cmd([[autocmd FileType scss setlocal shiftwidth=2 softtabstop=2 expandtab]])

-- Vue.js
vim.cmd([[autocmd FileType vue setlocal shiftwidth=2 softtabstop=2 expandtab]])

-- txt
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.txt", command = "setlocal signcolumn=yes:2" }) -- better margins

-- Markdown
lazy({ "godlygeek/tabular" })
lazy({ "preservim/vim-markdown" })
vim.g.vim_markdown_folding_disabled = 1
