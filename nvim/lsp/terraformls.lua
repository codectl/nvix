-- Using 0.38.2 from ~/.local/bin because 0.38.3 (Homebrew) has broken embedded provider schemas
-- Install: curl -sL "https://releases.hashicorp.com/terraform-ls/0.38.2/terraform-ls_0.38.2_darwin_arm64.zip" -o /tmp/tfls.zip && unzip -p /tmp/tfls.zip terraform-ls > ~/.local/bin/terraform-ls && chmod +x ~/.local/bin/terraform-ls && rm /tmp/tfls.zip
-- claude conversation in nvim-dev dir
return {
  cmd = { vim.fn.expand("~/.local/bin/terraform-ls"), "serve" },
  filetypes = { "terraform", "tf", "tfvars" },
  root_markers = { ".terraform", ".git" },
  single_file_support = true,
}
