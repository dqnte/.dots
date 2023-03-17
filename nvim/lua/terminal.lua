-- Integrations
lazy({ "fladson/vim-kitty" })

-- tmux
lazy({ "christoomey/vim-tmux-navigator" })
keymap("n", "<C-J>", "<C-W><C-J>", { noremap = true, silent = true })
keymap("n", "<C-K>", "<C-W><C-K>", { noremap = true, silent = true })
keymap("n", "<C-L>", "<C-W><C-L>", { noremap = true, silent = true })
keymap("n", "<C-H>", "<C-W><C-H>", { noremap = true, silent = true })

-- restore cursor to beam on exit
vim.cmd([[autocmd VimLeave * set guicursor=a:ver20]])
