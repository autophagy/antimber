{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-trailing-whitespace
      nerdtree
      vim-fugitive
      vim-airline
      vim-polyglot
      salt-vim
      vim-test
      fzf-vim
      gruvbox
      dhall-vim
      idris2-vim
      indentLine
      zig-vim
    ];

    extraConfig = ''
      set number

      set encoding=utf-8

      set foldmethod=indent
      set foldlevel=99
      nnoremap f za

      syntax on
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

      let g:idris_indent_if = 3
      let g:idris_indent_case = 5
      let g:idris_indent_let = 4
      let g:idris_indent_where = 6
      let g:idris_indent_do = 3
      let g:idris_indent_rewrite = 8

      let g:indentLine_char = ':'

      let g:indentLine_fileTypeExclude = ['markdown', 'rst']
    '';
  };
}
