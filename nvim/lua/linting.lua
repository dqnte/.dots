-- langauge syntax highlighting
-- Plug 'sheerun/vim-polyglot'

-- remove trailing white spaces
nvim_cmd("autocmd BufWritePre * :%s/\\s\\+$//e")

-- specific tab sizes
nvim_cmd([[
    autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab
]])
nvim_cmd([[
    autocmd FileType typescript setlocal shiftwidth=2 softtabstop=2 expandtab
]])
nvim_cmd([[
    autocmd FileType vue setlocal shiftwidth=2 softtabstop=2 expandtab
]])

-- enable spell in markdown files
vim.api.nvim_exec(
	[[
	augroup markdownSpell
		autocmd!
		autocmd FileType markdown setlocal spell
		autocmd BufRead,BufNewFile *.md setlocal spell
	augroup END
	]],
	false
)

-- markdown styles
Plug('godlygeek/tabular')
Plug('preservim/vim-markdown')
vim.g.vim_markdown_folding_disabled = 1
