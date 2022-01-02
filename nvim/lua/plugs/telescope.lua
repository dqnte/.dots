local telescope = require('telescope')

telescope.setup { defaults = { file_ignore_patterns = { "node_modules", "__pycache__" }}}

-- To get fzf loaded and working with telescope,
-- you need to call load_extension, somewhere after
-- the setup function.
telescope.load_extension('fzf')
