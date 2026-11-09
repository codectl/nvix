-- Plugins and config are provided by Nix (see flake.nix); g:nvix_plugins / g:nvix_config are set by the wrapper.
local lazypath = vim.g.nvix_plugins .. "/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  defaults = {
    lazy = true,
    version = false,
  },
  install = {
    missing = false,
    colorscheme = { "catppuccin" },
  },
  dev = {
    path = vim.g.nvix_plugins,
    patterns = { "" },
    fallback = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      paths = { vim.g.nvix_config },
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin",
        "tarPlugin", "tohtml", "tutor", "zipPlugin"
      },
    },
  },
  ui = {
    border = "rounded",
    backdrop = 60,
  },
  checker = {
    enabled = false,
  },
  change_detection = {
    enabled = false,
  },
  debug = false,
})
