-- Plug 'dense-analysis/ale'    -- linting pluggin
Plug 'sheerun/vim-polyglot'  -- langauge syntax highlighting

-- vim.g.ale_linters = { python = {'flake8', 'mypy'}, javascript = {'prettier', 'eslint'}}
-- vim.g.ale_fixers = { python = {'black', 'isort'}, javascript = {'prettier', 'eslint'}}

nvim_cmd("autocmd BufWritePre * :%s/\\s\\+$//e") -- remove trailing white spaces
