set nocompatible
syntax enable

set hidden

set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
filetype plugin indent on

set hlsearch
set ignorecase
set smartcase
set noerrorbells

set number
highlight LineNr ctermfg=darkgrey

set backupdir=~/.vim/backup//
set directory=~/.vim/backup//

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
