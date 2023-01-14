-- JS/TS
vim.cmd([[autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab]])
vim.cmd([[autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab]])

-- Vue.js
Plug("posva/vim-vue") -- highlighting
vim.cmd([[autocmd FileType vue setlocal shiftwidth=2 softtabstop=2 expandtab]])

-- txt
autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.txt", command = "setlocal signcolumn=yes:2" }) -- better margins
autocmd(
	{ "BufRead", "BufNewFile" },
	{ pattern = "*.txt", command = "setlocal laststatus=0 noshowcmd noruler noshowmode" }
) -- remove status line

-- Markdown
Plug("godlygeek/tabular")
Plug("preservim/vim-markdown")
autocmd(
	{ "BufRead", "BufNewFile" },
	{ pattern = "*.md", command = "setlocal laststatus=0 noshowcmd noruler noshowmode" }
) -- remove status line
-- vim.cmd([[autocmd FileType markdown setlocal spell]])
-- vim.cmd([[autocmd BufRead,BufNewFile *.md setlocal spell]])
vim.g.vim_markdown_folding_disabled = 1
