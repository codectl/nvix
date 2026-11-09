return {
  "mrjones2014/legendary.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    {
      "<S-l>",
      function()
        require("legendary").find()
        vim.api.nvim_feedkeys("i", "n", false)
      end,
      desc = "Legendary: Command Menu",
    },
  },
  config = function()
    require("legendary").setup({
      lazy_nvim = {
        auto_register = true,
      },
      include_builtin = false,
      include_legendary_cmds = false,
      select_prompt = "Legendary",
      col_separator_char = '',
      sort = {
        most_recent_first = false,
        user_items_first = false,
      },
      extensions = {
        lazy_nvim = true,
      },
      keymaps = {
        {
          itemgroup = "Custom",
          description = "Custom keybindings",
          keymaps = {
            { "<C-w> Left",  "<C-w>h",       description = "Move to left window" },
            { "<C-w> Down",  "<C-w>j",       description = "Move to window below" },
            { "<C-w> Up",    "<C-w>k",       description = "Move to window above" },
            { "<C-w> Right", "<C-w>l",       description = "Move to right window" },
            { "<S-k>",       mode = { "v" }, description = "Move selected line up" },
            { "<S-j>",       mode = { "v" }, description = "Move selected line down" },
            { "<C-d>",       "<C-d>zz",      description = "Scroll down half page centered" },
            { "<C-u>",       "<C-u>zz",      description = "Scroll up half page centered" },
          }
        },
        {
          itemgroup = "Builtin",
          description = "Builtin keybindings",
          keymaps = {
            { "<C-w>s", ":split<CR>",    description = "Horizontal split" },
            { "<C-w>v", ":vsplit<CR>",   description = "Vertical split" },
            { "<C-w>=", ":wincmd =<CR>", description = "Equalize window sizes" },
          }
        },
        {
          itemgroup = "Tmux",
          description = "Tmux keybindings (reference)",
          keymaps = {
            { "<C-a> o",          "Cycle through panes",       mode = { "n" }, description = "Tmux: cycle through panes" },
            { "<C-a> Up",         "Move to pane above",        mode = { "n" }, description = "Tmux: move to pane above" },
            { "<C-a> Down",       "Move to pane below",        mode = { "n" }, description = "Tmux: move to pane below" },
            { "<C-a> Left/Right", "Switch tmux sessions",      mode = { "n" }, description = "Tmux: switch between sessions" },
            { "<C-a> |",          "Split window vertically",   mode = { "n" }, description = "Tmux: vertical split" },
            { "<C-a> -",          "Split window horizontally", mode = { "n" }, description = "Tmux: horizontal split" },
            { "<C-a> z",          "Toggle zoom pane",          mode = { "n" }, description = "Tmux: toggle zoom current pane" },
            { "<C-a> c",          "New window",                mode = { "n" }, description = "Tmux: create new window" },
            { "<C-a> t",          "Toggle status bar",         mode = { "n" }, description = "Tmux: toggle status bar" },
            { "<C-a> f",          "Reattach floating popup",   mode = { "n" }, description = "Tmux: open/reattach floating popup" },
            { "<C-a> F",          "New floating popup",        mode = { "n" }, description = "Tmux: create new floating popup" },
            { "<C-a> d",          "Detach/dismiss popup",      mode = { "n" }, description = "Tmux: dismiss floating popup" },
          }
        },
        {
          itemgroup = "Tmuxer Session Picker",
          description = "Tmuxer session picker keybindings (reference)",
          keymaps = {
            { "<Right>/<Left>", "Expand/collapse current item",          description = "Tmuxer: expand/collapse current item" },
            { "<C-e>",          "Toggle expand/collapse everything",     description = "Tmuxer: toggle expand/collapse everything" },
            { "<C-d>",          "Kill selected session(s) or window(s)", description = "Tmuxer: kill selected entries" },
            { "<Tab>",          "Multi-select",                          description = "Tmuxer: multi-select" },
          }
        }
      },
    })
  end,
}
