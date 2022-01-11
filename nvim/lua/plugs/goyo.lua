Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

-- you will also need to comment out a specific line in goyo because it
-- overwrites specific styles on return exit
--
-- execute 'colo '. get(g:, 'colors_name', 'default')

vim.g.limelight_conceal_ctermfg=237

vim.g.goyo_enter = function()
  vim.g.showmode = false
  vim.g.showcmd = false
  vim.cmd("Limelight")
  vim.cmd("Gitsigns toggle_signs")
end
vim.cmd("autocmd! User GoyoEnter nested call goyo_enter()")

vim.g.goyo_leave = function()
  vim.g.showmode = true
  vim.g.showcmd = true
  vim.cmd("Limelight!")
  vim.cmd("Gitsigns toggle_signs")
end
vim.cmd("autocmd! User GoyoLeave nested call goyo_leave()")
