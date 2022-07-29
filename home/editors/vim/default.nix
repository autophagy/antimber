{ pkgs, ... }:
let
  mkLuaPlugin = { plugin, file }: (
    {
      inherit plugin;
      config = ''
        lua <<EOF
        ${builtins.readFile file}
        EOF
      '';
    }
  );
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
      # Themes
      gruvbox

      # Completion/Linting/Highlighting
      vim-trailing-whitespace
      indentLine
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      luasnip
      cmp_luasnip
      cmp-treesitter
      lsp-status-nvim
      (mkLuaPlugin {
        plugin = nvim-cmp;
        file = ./cmp.lua;
      })
      (mkLuaPlugin {
        plugin = (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars));
        file = ./treesitter.lua;
      })
      (mkLuaPlugin {
        plugin = nvim-lspconfig;
        file = ./lspconfig.lua;
      })
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

      # Languages
      dhall-vim
      vim-nix

      # Utils
      nerdtree # File system tree
      vim-fugitive # Git wrapper
      vim-airline # Status line
      vim-test # Test wrapper
      fzf-vim # Fuzzyfinder
    ];

    extraPackages = with pkgs; [
      shellcheck
      rnix-lsp
      nodePackages.bash-language-server
      terraform-lsp
      rls
      nodePackages.vscode-css-languageserver-bin
      yaml-language-server
    ];

    extraConfig = ''
      set number

      set encoding=utf-8

      set foldmethod=indent
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


      " Spelling settings

      set dictionary=/usr/share/dict/words
      set spelllang=en

      augroup nvim_opts
      au!
      au FileType markdown,rst,text,mail,tex setlocal spell
      augroup end

      nnoremap <C-J> <C-W><C-J>
      nnoremap <C-K> <C-W><C-K>
      nnoremap <C-L> <C-W><C-L>
      nnoremap <C-H> <C-W><C-H>

      vnoremap <leader>y "+y

      " air-line
      let g:airline_powerline_fonts = 1

      if !exists('g:airline_symbols')
      let g:airline_symbols = {}
      endif

      " unicode symbols
      let g:airline_left_sep = ''
      let g:airline_left_alt_sep = ''
      let g:airline_right_sep = ''
      let g:airline_right_alt_sep = ''
      let g:airline_symbols.crypt = '-'
      let g:airline_symbols.paste = 'ρ'
      let g:airline_symbols.paste = 'Þ'
      let g:airline_symbols.paste = '∥'
      let g:airline_symbols.spell = 'Ꞩ'
      let g:airline_symbols.notexists = 'Ɇ'
      let g:airline_symbols.whitespace = 'Ξ'
      let g:airline_symbols.branch = ''
      let g:airline_symbols.readonly = ''
      let g:airline_symbols.maxlinenr = ""
      let g:airline_symbols.dirty='⚡'
      let g:airline_symbols.linenr = ""

      let NERDTreeIgnore=['\.pyc$', '\~$']
      map <C-n> :NERDTreeToggle<CR>

      nmap <silent> t<C-n> :TestNearest<CR>
      nmap <silent> t<C-f> :TestFile<CR>
      nmap <silent> t<C-s> :TestSuite<CR>
      nmap <silent> t<C-l> :TestLast<CR>
      nmap <silent> t<C-g> :TestVisit<CR>

      let g:fzf_preview_window = ""
      let g:fzf_preview_window = ['right:50%', 'ctrl-/']
      nnoremap <silent> <C-p> :Files<CR>
      nnoremap <silent> <A-p> :Rg<CR>

      let g:indentLine_char = ':'

      let g:indentLine_fileTypeExclude = ['markdown', 'rst']
    '';
  };
}
