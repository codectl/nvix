{
  description = "nvix: Neovim + tmux, fully packaged with Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # plugins not in nixpkgs (flake = false → plain sources, bumped by `nix flake update`)
    tmuxer-nvim = { url = "github:codectl/tmuxer.nvim"; flake = false; };
    splitjoin-nvim = { url = "github:bennypowers/splitjoin.nvim"; flake = false; };
    quickr-preview-vim = { url = "github:ronakg/quickr-preview.vim"; flake = false; };
    vim-maximizer = { url = "github:szw/vim-maximizer"; flake = false; };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      systems = [ "aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs:
        let
          inherit (pkgs) lib;
          vp = pkgs.vimPlugins;

          fromInput = name: pkgs.vimUtils.buildVimPlugin {
            pname = name;
            version = inputs.${name}.shortRev or "src";
            src = inputs.${name};
            doCheck = false;
          };

          # nvim-treesitter (main branch) + precompiled grammars merged into one plugin dir,
          # so `vim.treesitter.start` finds parser/*.so on the runtimepath. No :TSInstall ever.
          treesitter =
            let
              ts = vp.nvim-treesitter.withPlugins (p: with p; [
                bash dockerfile go gomod gosum helm json lua markdown markdown_inline
                python regex rust terraform hcl vim vimdoc yaml query
              ]);
            in
            pkgs.symlinkJoin {
              name = "nvim-treesitter";
              paths = [ ts ] ++ ts.dependencies;
            };

          # Directory of <lazy plugin name> → store path. lazy.nvim's `dev.path` points here;
          # names must equal what lazy derives from the spec ("owner/repo" → "repo", catppuccin special-cased).
          lazyPlugins = pkgs.linkFarm "nvix-lazy-plugins" {
            "lazy.nvim" = vp.lazy-nvim;
            "Comment.nvim" = vp.comment-nvim;
            "alpha-nvim" = vp.alpha-nvim;
            "catppuccin" = vp.catppuccin-nvim;
            "cmp-nvim-lsp" = vp.cmp-nvim-lsp;
            "cmp-path" = vp.cmp-path;
            "fidget.nvim" = vp.fidget-nvim;
            "flash.nvim" = vp.flash-nvim;
            "gitsigns.nvim" = vp.gitsigns-nvim;
            "glance.nvim" = vp.glance-nvim;
            "legendary.nvim" = vp.legendary-nvim;
            "lspkind.nvim" = vp.lspkind-nvim;
            "mini.indentscope" = vp.mini-indentscope;
            "mini.pairs" = vp.mini-pairs;
            "neo-tree.nvim" = vp.neo-tree-nvim;
            "nui.nvim" = vp.nui-nvim;
            "nvim-cmp" = vp.nvim-cmp;
            "nvim-lspconfig" = vp.nvim-lspconfig;
            "nvim-surround" = vp.nvim-surround;
            "nvim-treesitter" = treesitter;
            "nvim-treesitter-textobjects" = vp.nvim-treesitter-textobjects;
            "nvim-ts-autotag" = vp.nvim-ts-autotag;
            "nvim-web-devicons" = vp.nvim-web-devicons;
            "obsidian.nvim" = vp.obsidian-nvim;
            "plenary.nvim" = vp.plenary-nvim;
            "schemastore.nvim" = vp.SchemaStore-nvim;
            "searchbox.nvim" = vp.searchbox-nvim;
            "telescope-fzf-native.nvim" = vp.telescope-fzf-native-nvim;
            "telescope-ui-select.nvim" = vp.telescope-ui-select-nvim;
            "telescope-undo.nvim" = vp.telescope-undo-nvim;
            "telescope.nvim" = vp.telescope-nvim;
            "todo-comments.nvim" = vp.todo-comments-nvim;
            "trouble.nvim" = vp.trouble-nvim;
            "tmuxer.nvim" = fromInput "tmuxer-nvim";
            "splitjoin.nvim" = fromInput "splitjoin-nvim";
            "quickr-preview.vim" = fromInput "quickr-preview-vim";
            "vim-maximizer" = fromInput "vim-maximizer";
          };

          nvimConfig = pkgs.runCommand "nvix-config" { } ''
            cp -r ${./nvim} $out
          '';

          # Binaries the config shells out to. Language servers are intentionally NOT here:
          # they come from each project's devShell and are picked up via PATH.
          nvimRuntimeDeps = with pkgs; [ ripgrep fd git ];

          nvim = pkgs.symlinkJoin {
            name = "nvix-nvim";
            paths = [ pkgs.neovim-unwrapped ];
            nativeBuildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram $out/bin/nvim \
                --set NVIM_APPNAME nvix \
                --prefix PATH : ${lib.makeBinPath nvimRuntimeDeps} \
                --add-flags "--cmd 'let g:nvix_plugins = \"${lazyPlugins}\" | let g:nvix_config = \"${nvimConfig}\"'" \
                --add-flags "--cmd 'set rtp^=${nvimConfig}'" \
                --add-flags "-u ${nvimConfig}/init.lua"
            '';
            meta.mainProgram = "nvim";
          };

          tmuxConf = pkgs.runCommand "nvix-tmux.conf" { } ''
            substitute ${./tmux/tmux.conf} $out \
              --subst-var out \
              --subst-var-by sensible ${pkgs.tmuxPlugins.sensible}/share/tmux-plugins/sensible/sensible.tmux \
              --subst-var-by tmux_fzf ${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/main.tmux
          '';

          tmux = pkgs.symlinkJoin {
            name = "nvix-tmux";
            paths = [ pkgs.tmux ];
            nativeBuildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram $out/bin/tmux \
                --prefix PATH : ${lib.makeBinPath [ pkgs.fzf nvim ]} \
                --add-flags "-f ${tmuxConf}"
            '';
            meta.mainProgram = "tmux";
          };

          # Shell layer: prompt + CLI tools the zshrc relies on, plus the zshrc itself at
          # share/nvix/zshrc. Machine-specific settings belong in ~/.zshrc.local, not here.
          shellTools = with pkgs; [ starship zoxide fzf fd eza gh zsh-autosuggestions ];

          zshrc = pkgs.runCommand "nvix-zshrc" { } ''
            substitute ${./zsh/zshrc} $out \
              --subst-var-by starship_config ${./starship/starship.toml} \
              --subst-var-by autosuggestions ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
          '';

          shell = pkgs.symlinkJoin {
            name = "nvix-shell";
            paths = shellTools;
            postBuild = ''
              mkdir -p $out/share/nvix
              ln -s ${zshrc} $out/share/nvix/zshrc
              ln -s ${./starship/starship.toml} $out/share/nvix/starship.toml
            '';
          };
        in
        {
          inherit nvim tmux shell;
          default = pkgs.symlinkJoin { name = "nvix"; paths = [ nvim tmux shell ]; meta.mainProgram = "nvim"; };
        });

      apps = forAllSystems (pkgs: {
        default = { type = "app"; program = nixpkgs.lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.nvim; };
        tmux = { type = "app"; program = nixpkgs.lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.tmux; };
      });
    };
}
