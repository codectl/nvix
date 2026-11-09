# nvix

Neovim 0.12, tmux and the zsh toolset, fully packaged with Nix: plugins, treesitter grammars, configs and runtime tools (`rg`, `fd`, `git`, `fzf`, `starship`, `zoxide`, `eza`, `gh`) are all in the store. Nothing is installed or compiled at runtime.

```sh
nix run github:codectl/nvix            # nvim
nix run github:codectl/nvix#tmux       # tmux
nix run github:codectl/nvix#shell      # nvix-zsh
nix profile install github:codectl/nvix   # nvim, tmux, nvix-zsh on PATH
```

## Layout

- `flake.nix` — `packages.{nvim,tmux,shell,default}`; plugins come from `nixpkgs.vimPlugins`, the rest (`tmuxer.nvim`, `splitjoin.nvim`, `quickr-preview.vim`, `vim-maximizer`) are flake inputs. `nix flake update` bumps everything.
- `nvim/` — the Neovim config (lazy.nvim specs, `lsp/*.lua`). lazy.nvim loads plugins from the Nix store via `dev.path`; installing/updating from inside nvim is disabled.
- `tmux/tmux.conf` — tmux config; `tmux-sensible` and `tmux-fzf` are wired in from nixpkgs instead of tpm.
- `zsh/zshrc`, `starship/starship.toml` — the shell config, baked into `nvix-zsh`: a wrapped zsh with `ZDOTDIR` in the store, plus `starship`, `zoxide`, `fzf`, `fd`, `eza`, `gh` on its `PATH`. The host's own zsh and `~/.zshrc` are never touched. The nvix `tmux` uses `nvix-zsh` as its default shell. Per-machine settings (KUBECONFIG, DB URLs, extra `PATH`) go in `~/.zshrc.local`, sourced by `nvix-zsh` if present.

## Language servers

Not included on purpose. Each project's `flake.nix` devShell provides its own servers; `lsp/*.lua` configs only activate when the binary is on `PATH`.

## State

Runs as `NVIM_APPNAME=nvix`, so data/state live in `~/.local/share/nvix` and `~/.local/state/nvix`, separate from any existing `~/.config/nvim`.
