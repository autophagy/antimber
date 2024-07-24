{ pkgs, nvimPlugins, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [ gruvbox-nvim ];

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
