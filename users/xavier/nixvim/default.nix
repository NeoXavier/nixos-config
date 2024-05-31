{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./keymaps.nix
    ./style.nix
    ./telescope.nix
    ./treesitter.nix
    ./lsp.nix
    ./completion.nix
    ./format.nix
    ./lint.nix
  ];

  config = {
    vimAlias = true;

    globals = {
      mapleader = " ";
    };

    opts = {
      guicursor = "";

      number = true;
      relativenumber = true;

      errorbells = false;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;

      smartindent = true;

      wrap = false;

      swapfile = false; #Undotree
      backup = false; #Undotree
      undofile = true;

      hlsearch = false;
      incsearch = true;
      ignorecase = true;
      smartcase = true;

      termguicolors = true;

      scrolloff = 8;
      signcolumn = "yes";

      colorcolumn = "80";

      hidden = true;
      ttimeoutlen = 0;
    };

    plugins = {
      gitsigns.enable = true;
      oil.enable = true;
      undotree.enable = true;
      fugitive.enable = true;
      comment-nvim.enable = true;
    };
    extraPlugins = with pkgs.vimPlugins; [
      {
        plugin = gruvbox-material;
        config = ''
          let g:gruvbox_material_forground = 'mix'
          let g:gruvbox_material_background = 'hard'
          let g:gruvbox_material_ui_contrast = 'high'
          colorscheme gruvbox-material
        '';
      }
    ];
    extraPackages = with pkgs; [
      # Formatters
      alejandra
      asmfmt
      astyle
      black
      cmake-format
      gofumpt
      golines
      gotools
      isort
      nodePackages.prettier
      prettierd
      rustfmt
      shfmt
      stylua
      # Linters
      commitlint
      eslint_d
      golangci-lint
      hadolint
      html-tidy
      luajitPackages.luacheck
      markdownlint-cli
      nodePackages.jsonlint
      pylint
      ruff
      shellcheck
      vale
      yamllint
      # Debuggers / misc deps
      asm-lsp
      bashdb
      clang-tools
      delve
      fd
      gdb
      go
      lldb_17
      llvmPackages_17.bintools-unwrapped
      marksman

      # (nerdfonts.override {
      #   fonts = [
      #     "JetBrainsMono"
      #     "RobotoMono"
      #   ];
      # })

      python3
      ripgrep
      rr
      tmux-sessionizer
      zig
    ];
  };
}
