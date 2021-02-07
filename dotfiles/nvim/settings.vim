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

