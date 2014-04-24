set nocompatible
filetype off
syntax enable

set hidden

set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2

set hlsearch
set ignorecase
set smartcase
set noerrorbells

set number
highlight LineNr ctermfg=darkgrey

set backupdir=~/.vim/backup//
set directory=~/.vim/backup//

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o

let mapleader = ","
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprev<CR>

" Begin Vundle
set rtp+=~/.vim/bundle/Vundle.vim/ " set the runtime path to include Vundle and initialize
call vundle#begin()

Plugin 'gmarik/vundle.vim' " let Vundle manage Vundle, required

Plugin 'kien/ctrlp.vim.git'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

Plugin 'tpope/vim-fugitive.git'

call vundle#end()
" end Vundle

filetype plugin indent on

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
