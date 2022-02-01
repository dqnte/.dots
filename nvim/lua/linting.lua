-- langauge syntax highlighting
-- Plug 'sheerun/vim-polyglot'

-- remove trailing white spaces
nvim_cmd("autocmd BufWritePre * :%s/\\s\\+$//e")

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
