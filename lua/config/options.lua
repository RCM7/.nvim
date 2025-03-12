vim.opt.tabstop = 2
vim.opt.softtabstop = 2  
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Yanking works seamlessly with mac os clipboard
vim.opt.clipboard = "unnamedplus"

-- Enable persistent undo
local undo_dir = vim.fn.expand("~/.config/nvim/undodir")
vim.opt.undofile = true
vim.opt.undodir = undo_dir


