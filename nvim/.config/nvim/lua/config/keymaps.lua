-- Keymaps are automatically loaded on the VeryLazy event
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local map = vim.keymap.set

-- jj to leave insert mode
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Keep cursor centered when jumping / searching
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next match (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev match (centered)" })

-- Paste over a selection without clobbering the register
map("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })
