return {
  "goolord/alpha-nvim",
  enabled = true,
  event = "VimEnter",
  priority = 50,
  lazy = true,
  keys = {
    { ";", "<cmd>Alpha<CR>", desc = "Dashboard: Alpha Menu" },
  },
  opts = function()
    local dashboard = require("alpha.themes.dashboard")

    local logo = [[
                                                     
              ████ ██████           █████      ██
             ███████████             █████ 
             █████████ ███████████████████ ███   ███████████
            █████████  ███    █████████████ █████ ██████████████
           █████████ ██████████ █████████ █████ █████ ████ █████
         ███████████ ███    ███ █████████ █████ █████ ████ █████
        ██████  █████████████████████ ████ █████ █████ ████ ██████

                              nix only
     ]]
    dashboard.section.header.val = vim.split(logo, "\n")
    dashboard.section.buttons.val = vim.tbl_map(function(btn)
      local button = dashboard.button(btn[1], btn[2] .. " " .. btn[3], btn[4])
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
      return button
    end, {
      { "f", "", "Find file", ":Telescope fd <CR>" },
      { "n", "", "New file", ":ene <BAR> startinsert <CR>" },
      { "r", "", "Recent files", ":Telescope oldfiles <CR>" },
      { "g", "", "Find text", ":Telescope live_grep <CR>" },
      { "l", "󰒲", "Lazy", ":Lazy<CR>" },
      { "q", "", "Quit", ":qa<CR>" }
    })

    -- logo in AlphaHeader, the "nix only" tagline in AlphaTagline
    dashboard.section.header.opts.hl = vim.tbl_map(function(line)
      return { { line:find("nix only") and "AlphaTagline" or "AlphaHeader", 0, -1 } }
    end, dashboard.section.header.val)
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 8
    return dashboard
  end,
  config = function(_, dashboard)
    require("alpha").setup(dashboard.opts)
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local lazy_stats = require("lazy.stats").stats()
        local ms = (math.floor(lazy_stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = string.format(
          "Neovim loaded %d plugins in %.2fms",
          lazy_stats.count,
          ms
        )
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
