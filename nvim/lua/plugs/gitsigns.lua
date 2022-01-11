Plug 'lewis6991/gitsigns.nvim'

local function start_gitsigns()
    require 'gitsigns'.setup{
        -- signs config
 	    current_line_blame = true,
 	    current_line_blame_opts = {
 		    virt_text_pos = 'right_align',
            virt_text_pos = 'eol'
 	    }
    }
end

vim.loaded.start_gitsigns = start_gitsigns
