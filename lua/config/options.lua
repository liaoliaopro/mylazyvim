-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- editor settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

-- disable undofile
vim.opt.undofile = false

-- set default python
vim.g.python3_host_prog = "~/.rye/shims/python3"
vim.g.python_host_prog = "~/.rye/shims/python"

-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "basedpyright"
