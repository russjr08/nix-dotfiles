{ inputs, pkgs, lib, ... }: 

let
  # installs a vim plugin from git with a given tag / branch
  # https://breuer.dev/blog/nixos-home-manager-neovim
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };

  # always installs latest version
  plugin = pluginGit "HEAD";
in {

  programs.neovim = {
    enable = true;
    vimAlias = true;

    # Necessary packages for nvim plugins
    extraPackages = with pkgs; [
      # Tree-sitter grammer
      tree-sitter

      # Rust things
      rust-analyzer

      # Clang Powered LSP
      ccls

      # Java LSP
      jdt-language-server

    ];

    extraConfig = builtins.concatStringsSep "\n" [
      (lib.strings.fileContents ./include/base.vim)
      (lib.strings.fileContents ./include/plugins.vim)

      # Lua based config files
      ''
      lua << EOF
      ${lib.strings.fileContents ./include/config.lua}
      ${lib.strings.fileContents ./include/keybinds.lua}
      EOF
      ''

    ];

    plugins = with pkgs.vimPlugins; [
      # Plugins already included in nixpkgs

      vim-plug
      telescope-nvim
      nvim-treesitter.withAllGrammars
      barbar-nvim
      nerdcommenter
      which-key-nvim
      plenary-nvim
      nvim-web-devicons
      nvim-tree-lua
      lualine-nvim
      coq_nvim
      coq-thirdparty
      coq-artifacts
      nvim-dap
      trouble-nvim
      editorconfig-nvim
      nvim-lightbulb
      nvim-code-action-menu
      toggleterm-nvim
      lazygit-nvim

      # Themes
      nvcode-color-schemes-vim

      # Language Support
      nvim-lspconfig
      vim-nix
      rust-tools-nvim
      kotlin-vim
      rust-tools-nvim
      vim-markdown

      # Plugins from Git
      (plugin "NLKNguyen/papercolor-theme")

    ];
  };


}
