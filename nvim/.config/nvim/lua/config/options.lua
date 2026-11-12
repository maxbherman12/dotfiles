-- Options are automatically loaded before lazy.nvim startup
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
local opt = vim.opt

opt.scrolloff = 8 -- keep 8 lines visible above/below the cursor
opt.wrap = false
opt.swapfile = false
opt.undofile = true -- persistent undo across sessions
opt.colorcolumn = "100"
opt.timeoutlen = 300 -- also governs how quickly `jj` has to be typed
