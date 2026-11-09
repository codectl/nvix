# nvix

Neovim 0.12 and tmux, fully packaged with Nix: plugins, treesitter grammars, config and runtime tools (`rg`, `fd`, `git`, `fzf`) are all in the store. Nothing is installed or compiled at runtime.

```sh
nix run github:dkooll/nvix            # nvim
nix run github:dkooll/nvix#tmux       # tmux
nix profile install github:dkooll/nvix   # both on PATH
```

## Layout

- `flake.nix` — `packages.{nvim,tmux,default}`; plugins come from `nixpkgs.vimPlugins`, the rest (`tmuxer.nvim`, `splitjoin.nvim`, `quickr-preview.vim`, `vim-maximizer`) are flake inputs. `nix flake update` bumps everything.
- `nvim/` — the Neovim config (lazy.nvim specs, `lsp/*.lua`). lazy.nvim loads plugins from the Nix store via `dev.path`; installing/updating from inside nvim is disabled.
- `tmux/tmux.conf` — tmux config; `tmux-sensible` and `tmux-fzf` are wired in from nixpkgs instead of tpm.

## Language servers

Not included on purpose. Each project's `flake.nix` devShell provides its own servers; `lsp/*.lua` configs only activate when the binary is on `PATH`.

## State

Runs as `NVIM_APPNAME=nvix`, so data/state live in `~/.local/share/nvix` and `~/.local/state/nvix`, separate from any existing `~/.config/nvim`.
