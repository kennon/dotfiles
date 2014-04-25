set nocompatible
filetype off
syntax enable
set mouse=a

set hidden

set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set scrolloff=8

set hlsearch
set ignorecase
set smartcase
set noerrorbells

set number
highlight LineNr ctermfg=darkgrey

set backupdir=~/.vim/backup//
set directory=~/.vim/backup//

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o

" quicker jump between scope delimiters
map <tab> %

" quickly select a line
nnoremap vv ^vg_

let mapleader = " "
nnoremap <silent> <Leader>n :bnext<CR>
nnoremap <silent> <Leader>p :bprev<CR>

" Begin Vundle
set rtp+=~/.vim/bundle/Vundle.vim/ " set the runtime path to include Vundle and initialize
call vundle#begin()

Plugin 'gmarik/vundle.vim' " let Vundle manage Vundle, required

Plugin 'kien/ctrlp.vim.git'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

Plugin 'tpope/vim-fugitive.git'

" Plugin 'avakhov/vim-yaml'

Plugin 'scrooloose/nerdtree'
map <Leader>t :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.o$']

Plugin 'bronson/vim-visual-star-search'

call vundle#end()
" end Vundle

filetype plugin indent on

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
