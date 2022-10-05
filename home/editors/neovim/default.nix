{ pkgs, nvimPlugins, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      # Themes
      gruvbox-nvim

      # Completion/Linting/Highlighting
      vim-trailing-whitespace
      {
        plugin = indentLine;
        config = ''
          let g:indentLine_char = ':'
          let g:indentLine_fileTypeExclude = ['markdown', 'rst']
        '';
      }
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      luasnip
      cmp_luasnip
      cmp-treesitter
      lsp-status-nvim
      {
        plugin = lsp_lines-nvim;
        type = "lua";
        config = builtins.readFile ./lsplines.lua;
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./cmp.lua;
      }
      {
        plugin = nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars);
        type = "lua";
        config = builtins.readFile ./treesitter.lua;
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./lspconfig.lua;
      }
      {
        plugin = lspsaga-nvim;
        config = ''
          " show hover doc
          nnoremap <silent>K :Lspsaga hover_doc<CR>
          " lsp provider to find the cursor word definition and reference
          nnoremap <silent> gh :Lspsaga lsp_finder<CR>
          " show code actions from lsp
          nnoremap <silent> ca :Lspsaga code_action<CR>
          " Jump between diagnostics
          nnoremap <silent> <C-p> :Lspsaga diagnostic_jump_prev<CR>
          nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>
          " scroll down hover doc or scroll in definition preview
          nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
          " scroll up hover doc
          nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
        '';
      }
      plenary-nvim
      {
        plugin = null-ls-nvim;
        type = "lua";
        config = builtins.readFile ./null_ls.lua;
      }
      {
        plugin = cmp-spell;
        type = "lua";
        config = builtins.readFile ./spell.lua;
      }

      # Languages
      dhall-vim
      vim-nix

      # Utils
      {
        plugin = nerdtree;
        config = ''
          let NERDTreeIgnore=['\.pyc$', '\~$']
          map <C-n> :NERDTreeToggle<CR>
        '';
      }
      vim-fugitive # Git wrapper
      {
        plugin = lualine-nvim;
        type = "lua";
        config = builtins.readFile ./lualine.lua;
      }
      {
        plugin = vim-test;
        config = ''
          nmap <silent> t<C-n> :TestNearest<CR>
          nmap <silent> t<C-f> :TestFile<CR>
          nmap <silent> t<C-s> :TestSuite<CR>
          nmap <silent> t<C-l> :TestLast<CR>
          nmap <silent> t<C-g> :TestVisit<CR>
        '';
      }
      {
        plugin = fzf-vim;
        config = ''
          let g:fzf_preview_window = ""
          let g:fzf_preview_window = ['right:50%', 'ctrl-/']
          nnoremap <silent> <C-p> :Files<CR>
          nnoremap <silent> <A-p> :Rg<CR>
        '';
      }
      {
        plugin = nvimPlugins.nvim-scrollbar;
        type = "lua";
        config = ''
          require("scrollbar").setup()
        '';
      }
      vim-sleuth
    ];

    extraPackages = with pkgs; [
      shellcheck
      rnix-lsp
      nodePackages.bash-language-server
      terraform-lsp
      rust-analyzer
      nodePackages.vscode-css-languageserver-bin
      yaml-language-server
      statix
      yamllint
      dhall-lsp-server
      gopls
    ];

    extraConfig = ''
      set number

      set encoding=utf-8

      set foldmethod=expr
      set foldexpr=nvim_treesitter#foldexpr()
      set foldlevel=99
      nnoremap f za

      filetype on
      filetype plugin indent on

      colorscheme gruvbox

      set cursorline
      set scrolloff=5

      set smartindent

      set expandtab

      set tabstop=4
      set shiftwidth=4

      set background=dark

      if exists("&colorcolumn")
      augroup colorcol
        autocmd!
        autocmd InsertEnter * set colorcolumn=80
        autocmd InsertLeave * set colorcolumn=""
      augroup end
      endif

      nnoremap <C-J> <C-W><C-J>
      nnoremap <C-K> <C-W><C-K>
      nnoremap <C-L> <C-W><C-L>
      nnoremap <C-H> <C-W><C-H>

      vnoremap <leader>y "+y
    '';
  };
}
