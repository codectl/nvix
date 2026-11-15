-- Tokyo Night Storm, contrast lifted for projectors / screen-share.
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "storm",
    transparent = true,
    styles = {
      comments = { italic = false }, -- italics blur on projectors
      keywords = { italic = false },
      sidebars = "transparent",
      floats = "transparent",
    },
    on_colors = function(c)
      c.comment = "#8a93c4"   -- default #565f89 vanishes on a beamer
      c.fg_gutter = "#5a6394" -- line numbers / indent guides
      c.border = "#7aa2f7"
    end,
    on_highlights = function(hl, c)
      hl.LineNr = { fg = c.fg_gutter }
      hl.CursorLineNr = { fg = c.orange, bold = true }
      hl.Visual = { bg = "#3b4261" }
      hl.Search = { fg = c.bg, bg = c.yellow, bold = true }
      hl.CurSearch = { fg = c.bg, bg = c.orange, bold = true }
      hl.IncSearch = { link = "CurSearch" }
      hl.MatchParen = { fg = c.orange, bg = "#3d59a1", bold = true }
      hl.WinSeparator = { fg = c.border }
      hl.FloatBorder = { fg = c.border }
      hl.FoldColumn = { fg = c.fg_gutter }
      hl.Folded = { fg = c.comment }
      hl.DiffAdd = { bg = "#2d4a3d" }
      hl.DiffDelete = { bg = "#4a2f3d" }
      hl.DiffChange = { bg = "#2f3b55" }
      hl.DiffText = { bg = "#3d5a8a", bold = true }
      local tmux_line = "#1c1c1c" -- tmux pane-active-border-style
      hl.TelescopeBorder = { fg = tmux_line }
      hl.TelescopePromptBorder = { fg = tmux_line }
      hl.TelescopeResultsBorder = { fg = tmux_line }
      hl.TelescopePreviewBorder = { fg = tmux_line }
      hl.TelescopeSelection = { fg = c.blue, bold = true }
      hl.TelescopeSelectionCaret = { fg = c.blue }
      hl.TelescopePromptPrefix = { fg = c.blue }
      hl.TelescopeMatching = { fg = c.blue, bold = true }
      hl.TelescopeTitle = { fg = c.blue, bold = true }
      hl.TelescopePromptTitle = { fg = c.blue, bold = true }
      hl.TelescopeResultsTitle = { fg = c.blue, bold = true }
      hl.TelescopePreviewTitle = { fg = c.blue, bold = true }
      -- Capture colors are theme-wide (same role = same color in every language).
      -- Terraform only gets extra captures via after/queries/terraform/highlights.scm.
      hl["@variable.builtin"] = { fg = c.magenta } -- self/this/var/local: theme red is too loud
      hl["@property"] = { fg = c.blue }          -- keys / attribute names being defined (bucket = ...)
      hl["@variable.member"] = { fg = c.yellow } -- fields being accessed (var.name, self.x)
      -- Glance (gd/gr/gy/gi)
      hl.GlanceBorderTop = { fg = tmux_line }
      hl.GlanceListBorderBottom = { fg = tmux_line }
      hl.GlancePreviewBorderBottom = { fg = tmux_line }
      hl.GlanceNormal = { bg = "NONE" }
      hl.GlancePreviewNormal = { bg = "NONE" }
      hl.GlanceListNormal = { bg = "NONE" }
      hl.GlanceListCursorLine = { fg = c.blue, bold = true }
      hl.GlancePreviewCursorLine = { bg = "NONE" }
      hl.GlanceListMatch = { fg = c.blue, bg = "#3d59a1", bold = true }
      hl.GlancePreviewMatch = { fg = c.blue, bg = "#3d59a1", bold = true }
      hl.GlanceListFilepath = { fg = c.comment }
      hl.TmuxerArrow = { fg = c.blue, bold = true }
      -- Alpha dashboard
      hl.AlphaTagline = { fg = c.comment }
      hl.AlphaHeader = { fg = c.blue, bold = true }
      hl.AlphaButtons = { fg = c.fg_dark }
      hl.AlphaShortcut = { fg = c.comment, bold = true }
      hl.AlphaFooter = { fg = c.comment }
      hl.GlanceListFilename = { fg = c.fg, bold = true }
      hl.GlanceListCount = { fg = c.blue }
      hl.GlanceWinBarFilename = { fg = c.fg, bold = true }
      hl.GlanceWinBarFilepath = { fg = c.comment }
      hl.GlanceWinBarTitle = { fg = c.blue, bold = true }
      hl.GlanceIndent = { fg = c.fg_gutter }
      hl.GlanceFoldIcon = { fg = c.blue }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight")
    vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:hor20-Cursor,r-cr:hor20-Cursor,o:hor50-Cursor"
    vim.api.nvim_set_hl(0, "Cursor", { bg = "#7aa2f7" })
  end,
}
