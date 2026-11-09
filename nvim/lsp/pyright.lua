return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
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
