local api = vim.api
local opt = vim.opt

local myGroup = api.nvim_create_augroup("MyAutocmds", { clear = true })

-- Helper for creating autocommands
local function create_autocmd(event, pattern, callback)
  api.nvim_create_autocmd(event, {
    pattern = pattern,
    callback = callback,
    group = myGroup,
  })
end

-- Don’t auto-comment new lines
opt.formatoptions:remove({ 'c', 'r', 'o' })

-- Remove trailing whitespace on save (skip binary buffers)
create_autocmd("BufWritePre", "*", function()
  if vim.bo.binary then
    return
  end
  vim.cmd([[silent! keepjumps keeppatterns %s/\s\+$//e]])
end)

-- Go to last location when opening a file
create_autocmd("BufReadPost", "*", function()
  local mark = api.nvim_buf_get_mark(0, '"')
  local lcount = api.nvim_buf_line_count(0)
  if mark[1] > 0 and mark[1] <= lcount then
    pcall(api.nvim_win_set_cursor, 0, mark)
  end
end)

-- Close man pages with 'q'
create_autocmd("FileType", "man", function()
  vim.keymap.set('n', 'q', ':quit<CR>', { buffer = true, silent = true })
end)

-- Detect Helm template files
create_autocmd({ "BufRead", "BufNewFile" }, { "*.yaml.tpl", "*.yml.tpl", "*.tpl", "*.gotmpl" }, function()
  vim.bo.filetype = "helm"
end)

-- Detect YAML files in Helm chart directories
create_autocmd({ "BufRead", "BufNewFile" }, { "*.yaml", "*.yml" }, function()
  local file_path = vim.fn.expand("%:p"):gsub("\\", "/")
  -- Helm template YAML in templates/ should use helm filetype.
  if file_path:match("/templates/.*%.ya?ml$") then
    vim.bo.filetype = "helm"
    return
  end

end)

-- Clear cursor line after colorscheme load
create_autocmd("ColorScheme", "*", function()
  api.nvim_set_hl(0, 'CursorLine', { bg = 'NONE' })
end)

