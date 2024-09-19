require "nvchad.options"

-- add yours here!
vim.opt.relativenumber = true
vim.opt.spelllang = 'en_us'
vim.opt.spell = true
-- Line wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.filetype.add({ extension = { templ = "templ" } })

-- Enable folding based on syntax
vim.o.foldmethod = 'syntax'
-- Set fold level to 1 by default
vim.o.foldlevel = 2 
-- Use Markdown syntax for folding
vim.g.markdown_folding = 1

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
