-- terraform-ls comes from the project devShell (e.g. wam pins 0.38.2; 0.38.3+ has broken embedded provider schemas)
return {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform", "tf", "tfvars" },
  root_markers = { ".terraform", ".git" },
  single_file_support = true,
}
