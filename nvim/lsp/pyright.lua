return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  -- Priority tiers (nvim 0.11+): repo-root markers win tree-wide, so a nested
  -- `requirements.txt` (e.g. wac/backend/) never re-roots the server into a subdir.
  root_markers = { { "pyproject.toml", "pyrightconfig.json", ".git" }, "setup.py", "setup.cfg", "requirements.txt", "Pipfile" },
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      -- Make Pyright resolve imports from a per-project venv at `./.venv`.
      -- This matches the common convention used by uv/poetry/venv and avoids indexing system Python.
      venvPath = ".",
      venv = ".venv",
      analysis = {
        diagnosticSeverityOverrides = {
          reportUnusedImport = "none",
        },
      },
    },
  },
}
