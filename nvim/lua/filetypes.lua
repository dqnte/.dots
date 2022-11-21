require("plugs/treesitter")

-- JS/TS
vim.cmd([[autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab]])
vim.cmd([[autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab]])

-- Vue.js
Plug("posva/vim-vue") -- highlighting
Plug("JoosepAlviste/nvim-ts-context-commentstring") -- commenting
vim.cmd([[autocmd FileType vue setlocal shiftwidth=2 softtabstop=2 expandtab]])

-- txt
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.txt", command = "setlocal signcolumn=yes:2" }) -- better margins

-- Markdown
Plug("godlygeek/tabular")
Plug("preservim/vim-markdown")
vim.cmd([[autocmd FileType markdown setlocal spell]])
vim.cmd([[autocmd BufRead,BufNewFile *.md setlocal spell]])
vim.g.vim_markdown_folding_disabled = 1
