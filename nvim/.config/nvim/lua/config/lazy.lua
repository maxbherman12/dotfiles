local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- LazyVim core
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Languages
    { import = "lazyvim.plugins.extras.lang.python" },     -- pyright + ruff, venv-selector, debugpy
    { import = "lazyvim.plugins.extras.lang.typescript" }, -- ts/js/react (vtsls), js-debug-adapter
    { import = "lazyvim.plugins.extras.lang.tailwind" },   -- tailwind classes (Next.js)
    { import = "lazyvim.plugins.extras.lang.go" },         -- gopls, gofumpt, goimports, delve
    { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.lang.yaml" },
    { import = "lazyvim.plugins.extras.lang.markdown" },
    { import = "lazyvim.plugins.extras.lang.docker" },
    { import = "lazyvim.plugins.extras.lang.toml" },

    -- Formatting / linting (JS/TS projects)
    { import = "lazyvim.plugins.extras.linting.eslint" },
    { import = "lazyvim.plugins.extras.formatting.prettier" },

    -- Debugging & testing
    { import = "lazyvim.plugins.extras.dap.core" },        -- nvim-dap + UI, <leader>d*
    { import = "lazyvim.plugins.extras.test.core" },       -- neotest, <leader>t*

    -- Editor niceties
    { import = "lazyvim.plugins.extras.coding.mini-surround" },
    { import = "lazyvim.plugins.extras.editor.inc-rename" },
    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },

    -- Your own plugins / overrides (lua/plugins/*.lua)
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false, -- always use latest git commit; lazy-lock.json pins versions
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true, notify = false }, -- check for updates quietly
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
