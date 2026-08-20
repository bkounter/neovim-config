-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.snacks_animate = false
vim.opt.laststatus = 0

-- Enable inlay hints by default (type hints & parameter names in Rust/LSP)
vim.g.lazyvim_inlay_hints = { enabled = true }

