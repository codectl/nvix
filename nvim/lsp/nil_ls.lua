-- nil ships with nvix (flake.nix: nvimRuntimeDeps) — every project has a flake.nix, so editing Nix is editor-level
return {
  cmd = { "nil" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = {
    ["nil"] = {
      formatting = { command = { "nixfmt" } },
      nix = { flake = { autoArchive = false } },
    },
  },
}
