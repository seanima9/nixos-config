{ pkgs, config, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    globals.mapleader = " ";

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    opts = {
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      cursorline = true;
      termguicolors = true;
      mouse = "a";
      clipboard = "unnamedplus";
      undofile = true;
      ignorecase = true;
      smartcase = true;
      splitright = true;
      splitbelow = true;
      scrolloff = 8;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      updatetime = 250;
      wrap = false;
    };

    clipboard.providers.wl-copy.enable = true;

    extraPackages = with pkgs; [
      fzf
      ripgrep
      fd
      rust-analyzer
      rustc
      cargo
      clippy
      rustfmt
      nixfmt-rfc-style
    ];

    env.RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";

    plugins = {
      lz-n.enable = true;
      web-devicons.enable = true;
      lualine.enable = true;
      lspconfig.enable = true;
      blink-cmp.enable = true;

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash
          json
          lua
          markdown
          markdown_inline
          nix
          python
          rust
          toml
          vim
          vimdoc
          yaml
        ];
      };

      gitsigns = {
        enable = true;
        lazyLoad.settings.event = "BufReadPost";
      };

      fzf-lua = {
        enable = true;
        profile = "telescope";
        lazyLoad.settings = {
          cmd = "FzfLua";
          keys = [
            {
              __unkeyed-1 = "<leader>ff";
              __unkeyed-2 = "<cmd>FzfLua files<CR>";
              desc = "Find files";
            }
            {
              __unkeyed-1 = "<leader>fg";
              __unkeyed-2 = "<cmd>FzfLua live_grep<CR>";
              desc = "Live grep";
            }
          ];
        };
      };

      oil = {
        enable = true;
        settings.view_options.show_hidden = true;
        lazyLoad.settings = {
          cmd = "Oil";
          keys = [
            {
              __unkeyed-1 = "<leader>e";
              __unkeyed-2 = "<cmd>Oil<CR>";
              desc = "File explorer";
            }
          ];
        };
      };

      rustaceanvim = {
        enable = true;
        settings.server.default_settings.rust-analyzer.check.command = "clippy";
        lazyLoad.settings.ft = "rust";
      };

      conform-nvim = {
        enable = true;
        lazyLoad.settings.event = "BufReadPost";
        settings = {
          format_on_save = {
            lsp_format = "fallback";
            timeout_ms = 500;
          };
          formatters_by_ft = {
            python = [
              "ruff_organize_imports"
              "ruff_format"
            ];
            rust = [ "rustfmt" ];
            nix = [ "nixfmt" ];
          };
        };
      };
    };

    lsp.servers = {
      pyrefly.enable = true;
      ruff.enable = true;
      nixd.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.desc = "Goto definition";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options.desc = "References";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        options.desc = "Hover";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.desc = "Code action";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options.desc = "Rename";
      }
      {
        mode = "n";
        key = "<leader>d";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options.desc = "Line diagnostics";
      }
      {
        mode = "n";
        key = "[d";
        action.__raw = "function() vim.diagnostic.jump({ count = -1, float = true }) end";
        options.desc = "Previous diagnostic";
      }
      {
        mode = "n";
        key = "]d";
        action.__raw = "function() vim.diagnostic.jump({ count = 1, float = true }) end";
        options.desc = "Next diagnostic";
      }
    ];
  };
}
