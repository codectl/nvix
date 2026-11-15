return {
  {
    "dnlhc/glance.nvim",
    keys = {
      { "gd", "<CMD>Glance definitions<CR>",      desc = "Glance: Go to definition" },
      { "gr", "<CMD>Glance references<CR>",       desc = "Glance: Show references" },
      { "gy", "<CMD>Glance type_definitions<CR>", desc = "Glance: Go to type definition" },
      { "gi", "<CMD>Glance implementations<CR>",  desc = "Glance: Go to implementation" },
    },
    cmd = "Glance",
    config = function()
      require("glance").setup({
        height = 30,
        border = {
          enable = true,
          characters = {
            '╭', '─', '╮',
            '│', '│',
            '╰', '─', '╯'
          },
        },
        preview_win_opts = {
          cursorline = true,
          number = false,
          wrap = true,
        },
        list = {
          position = 'right',
          width = 0.33,
        },
        theme = {
          enable = false,
        },
        indent_lines = {
          enable = true,
          icon = '│',
        },
        folds = {
          fold_closed = '',
          fold_open = '',
          folded = true,
        },
        winbar = {
          enable = true,
        }
      })
    end
  }
}
