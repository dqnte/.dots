Plug 'lewis6991/gitsigns.nvim'

vim.loaded.start_gitsigns = function()
    require 'gitsigns'.setup{
 	    current_line_blame = true,
 	    current_line_blame_opts = {
            virt_text_pos = 'eol'
 	    }
    }
end
