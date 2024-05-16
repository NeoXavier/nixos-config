{ inputs, nixvim, ... }:

{ config, lib, pkgs, ... }:

let
  sources = import ../../nix/sources.nix;
  basePath = toString ./.;
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  # For our MANPAGER env var
  # https://github.com/sharkdp/bat/issues/1145
  manpager = (pkgs.writeShellScriptBin "manpager" (if isDarwin then ''
    sh -c 'col -bx | bat -l man -p'
  '' else ''
    cat "$1" | col -bx | bat --language man --style plain
  ''));

  # Nixvim
  nvimconfig = import ./nixvim;
  nvim = inputs.nixvim.legacyPackages.aarch64-linux.makeNixvimWithModule {
  inherit pkgs;
  module = nvimconfig;
  };
in
{

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./alacritty.nix
  ];


  # Home-manager 22.11 requires this be set. We never set it so we have
  # to use the old state version.
  home.stateVersion = "18.09";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = with pkgs; [
    asciinema
    bat
    fd
    fzf
    gh
    htop
    jq
    ripgrep
    tree
    autojump
    oh-my-zsh
    tree-sitter

    nvim


    # Node is required for Copilot.vim
    nodejs
  ] ++ (lib.optionals isDarwin [
    # This is automatically setup on Linux
    cachix
    tailscale
  ]) ++ (lib.optionals (isLinux) [
    chromium
    firefox
    rofi
    zathura
    xfce.xfce4-terminal
  ]);

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    MANPAGER = "${manpager}/bin/manpager";
  };

  # home.file.".gdbinit".source = ./gdbinit;
  # home.file.".inputrc".source = ./inputrc;

  xdg.configFile = {
    "i3/config".text = builtins.readFile ./i3;
    "rofi/config.rasi".text = builtins.readFile ./rofi;

    # tree-sitter parsers
    "nvim/parser/proto.so".source = "${pkgs.tree-sitter-proto}/parser";
    "nvim/queries/proto/folds.scm".source =
      "${sources.tree-sitter-proto}/queries/folds.scm";
    "nvim/queries/proto/highlights.scm".source =
      "${sources.tree-sitter-proto}/queries/highlights.scm";
    "nvim/queries/proto/textobjects.scm".source =
      ./textobjects.scm;
  } // (if isDarwin then {
    # Rectangle.app. This has to be imported manually using the app.
    "rectangle/RectangleConfig.json".text = builtins.readFile ./RectangleConfig.json;
  } else { }) // (if isLinux then {
    "ghostty/config".text = builtins.readFile ./ghostty.linux;
  } else { });
  #
  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.gpg.enable = !isDarwin;

  /* programs.bash = {
    enable = true;
    shellOptions = [];
    historyControl = [ "ignoredups" "ignorespace" ];
    initExtra = builtins.readFile ./bashrc;

    shellAliases = {
    ga = "git add";
    gc = "git commit";
    gco = "git checkout";
    gcp = "git cherry-pick";
    gdiff = "git diff";
    gl = "git prettylog";
    gp = "git push";
    gs = "git status";
    gt = "git tag";
    };
    };

    programs.direnv= {
    enable = true;

    config = {
    whitelist = {
    prefix= [
    "$HOME/code/go/src/github.com/hashicorp"
    "$HOME/code/go/src/github.com/mitchellh"
    ];

    exact = ["$HOME/.envrc"];
    };
    };
    };
  */


  programs.git = {
    enable = true;
    userName = "NeoXavier";
    userEmail = "xavierneo88@gmail.com";
    # signing = {
    #   key = "523D5DC389D273BC";
    #   signByDefault = true;
    # };
    # aliases = {
    #   cleanup = "!git branch --merged | grep  -v '\\*\\|master\\|develop' | xargs -n 1 -r git branch -d";
    #   prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
    #   root = "rev-parse --show-toplevel";
    # };
    extraConfig = {
      branch.autosetuprebase = "always";
      color.ui = true;
      # core.askPass = ""; # needs to be empty to use terminal for ask pass
      # credential.helper = "store"; # want to make this more secure
      github.user = "NeoXavier";
      push.default = "tracking";
      init.defaultBranch = "master";
    };
  };

  programs.tmux = {
    enable = true;
    shortcut = "a";
    secureSocket = false;

    # Remove delay when pressing escape
    escapeTime = 0;

    plugins = with pkgs; [
      tmuxPlugins.catppuccin
    ];

    extraConfig = ''
      # Colors
              set -g default-terminal "tmux-256color"
              set -ga terminal-overrides ",*256col*:Tc"
              set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
              set-environment -g COLORTERM "truecolor"

              unbind C-b
              set-option -g prefix C-a
              bind-key C-a send-prefix
              set -g status-style 'bg=#333333 fg=#5eacd3'

              bind r source-file ~/.tmux.conf
              set -g base-index 1

      # split panes using | and -
              bind | split-window -h
              bind - split-window -v
              unbind '"'
              unbind %

      # vim-like pane switching
              bind -r ^ last-window
              bind -r k select-pane -U
              bind -r j select-pane -D
              bind -r h select-pane -L
              bind -r l select-pane -R

      # don't rename windows automatically
              set-option -g allow-rename off

              bind c new-window -c "#{pane_current_path}"

              bind-key -r f run-shell "tmux neww ~/.local/bin/tmux-sessionizer"
    '';
  };


  programs.i3status = {
    enable = true;

    general = {
      colors = true;
      color_good = "#8C9440";
      color_bad = "#A54242";
      color_degraded = "#DE935F";
    };

    modules = {
      ipv6.enable = false;
      "wireless _first_".enable = false;
      "battery all".enable = false;
    };
  };

  programs.neovim = {
    enable = false;
    # package = pkgs.neovim-nightly;
    withPython3 = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    plugins = [
      # Telescope
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.popup-nvim
      pkgs.vimPlugins.telescope-nvim

      # Status and Buffer line
      pkgs.vimPlugins.lualine-nvim
      pkgs.vimPlugins.bufferline-nvim
      pkgs.vimPlugins.nvim-web-devicons

      # LSP
      pkgs.vimPlugins.lspkind-nvim
      pkgs.vimPlugins.lsp_extensions-nvim
      pkgs.vimPlugins.lspsaga-nvim
      pkgs.vimPlugins.symbols-outline-nvim

      pkgs.vimPlugins.nvim-treesitter
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.nvim-treesitter-textobjects
      pkgs.vimPlugins.undotree

      # LSP Zero
      # # LSP Support
      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.mason-nvim
      pkgs.vimPlugins.mason-lspconfig-nvim

      # # Autocompletion
      pkgs.vimPlugins.cmp-nvim-lsp
      pkgs.vimPlugins.cmp-buffer
      pkgs.vimPlugins.cmp-path
      pkgs.vimPlugins.cmp-cmdline
      pkgs.vimPlugins.nvim-cmp
      pkgs.vimPlugins.cmp_luasnip
      pkgs.vimPlugins.fidget-nvim

      # # Snippets
      pkgs.vimPlugins.luasnip
      pkgs.vimPlugins.friendly-snippets

      # Autopairs
      pkgs.vimPlugins.auto-pairs

      # Comments
      pkgs.vimPlugins.comment-nvim

      # Trouble
      pkgs.vimPlugins.trouble-nvim

      # Theme
      pkgs.vimPlugins.gruvbox-nvim
      pkgs.vimPlugins.gruvbox-material
      pkgs.vimPlugins.catppuccin-nvim

      # Copilot
      pkgs.vimPlugins.copilot-vim
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/lua/plugin/remap.lua}
      ${builtins.readFile ./nvim/lua/plugin/set.lua}
      ${builtins.readFile ./nvim/after/plugin/telescope.lua}
      ${builtins.readFile ./nvim/after/plugin/colors.lua}
      ${builtins.readFile ./nvim/after/plugin/copilot.lua}
      ${builtins.readFile ./nvim/after/plugin/format.lua}
      ${builtins.readFile ./nvim/after/plugin/lsp.lua}
      ${builtins.readFile ./nvim/after/plugin/luasnip.lua}
      ${builtins.readFile ./nvim/after/plugin/statusline.lua}
      ${builtins.readFile ./nvim/after/plugin/telescope.lua}
      ${builtins.readFile ./nvim/after/plugin/treesitter.lua}
      ${builtins.readFile ./nvim/after/plugin/trouble.lua}
      ${builtins.readFile ./nvim/after/plugin/setups.lua}
    '';

  };

  #home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/nvim";


  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "autojump"
      ];
      theme = "agnoster";
    };
  };

  xresources.extraConfig = builtins.readFile ./Xresources;

  # Make cursor not tiny on HiDPI screens
  home.pointerCursor = lib.mkIf (isLinux) {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };
}


