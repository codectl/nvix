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
      -- vimdiff (gitsigns diffthis / blame → commit): no row backgrounds; sign column + fold show the hunks
      hl.DiffAdd = { bg = "NONE" }
      hl.DiffDelete = { fg = c.fg_gutter, bg = "NONE" }
      hl.DiffChange = { bg = "NONE" }
      hl.DiffText = { bg = "NONE", bold = true, underline = true }
      -- commit/patch buffers (gitsigns blame → show commit): colored text, no row backgrounds
      hl.diffAdded = { fg = c.green }
      hl.diffRemoved = { fg = c.red }
      hl.diffChanged = { fg = c.blue }
      hl.diffOldFile = { fg = c.red }
      hl.diffNewFile = { fg = c.green }
      hl.diffFile = { fg = c.blue, bold = true }
      hl.diffLine = { fg = c.comment }
      hl.diffIndexLine = { fg = c.comment }
      hl["@diff.plus"] = { fg = c.green }
      hl["@diff.minus"] = { fg = c.red }
      hl["@diff.delta"] = { fg = c.blue }
      hl.GitSignsAddLn = { bg = "NONE" }
      hl.GitSignsDeleteLn = { bg = "NONE" }
      hl.GitSignsChangeLn = { bg = "NONE" }
      -- Obsidian notes (obsedian.lua applies these via winhighlight / extmarks)
      hl.NotesAccentBold = { fg = c.blue, bold = true }
      hl.NotesBrown = { fg = c.comment }
      hl.NotesBlue = { fg = c.blue }
      hl.ObsidianParentDir = { fg = c.comment }
      hl.NotesWhiteItalic = { fg = c.fg_dark, italic = true }
      hl.NotesLightItalic = { fg = c.fg_dark, italic = true }
      hl.NotesYamlString = { fg = c.comment, italic = true }
      hl.NotesYamlKey = { fg = c.fg_dark }
      hl.NotesSearchMatch = { bg = "#3b4261" }
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
      hl["@variable.member"] = { link = "@variable" } -- field access reads as a plain variable; theme teal disliked
      hl["@type.builtin"] = { fg = c.blue1 }     -- string/number/object(...): theme dims these, keep full type color
      hl["@string.special"] = { fg = c.magenta } -- names-as-strings: terraform block labels, tags
      -- completion menu (nvim-cmp): no background, selected row by color only
      hl.Pmenu = { bg = "NONE" }
      hl.PmenuSel = { fg = c.blue, bg = "NONE", bold = true }
      hl.PmenuSbar = { bg = "NONE" }
      hl.PmenuThumb = { bg = c.fg_gutter }
      hl.CmpItemAbbrMatch = { fg = c.blue, bold = true }
      hl.CmpItemAbbrMatchFuzzy = { fg = c.blue, bold = true }
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
