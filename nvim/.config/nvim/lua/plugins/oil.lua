-- oil.nvim: edit the filesystem like a buffer
-- `-` opens the parent directory of the current file; `nvim .` opens oil.
return {
  {
    "stevearc/oil.nvim",
    lazy = false, -- needed so oil can take over `nvim <dir>`
    dependencies = { "nvim-mini/mini.icons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory (oil)" },
      { "<leader>-", function() require("oil").toggle_float() end, desc = "Oil (float)" },
    },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = { show_hidden = true },
      keymaps = {
        ["q"] = "actions.close",
        ["<C-h>"] = false, -- keep window navigation
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
      },
    },
  },

  -- Let oil own directory buffers instead of the snacks explorer (<leader>e still works)
  {
    "folke/snacks.nvim",
    opts = { explorer = { replace_netrw = false } },
  },
}
