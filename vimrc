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
nnoremap <silent> <Leader>l :ls<CR>

"
" visual searching
" From http://got-ravings.blogspot.com/2008/07/vim-pr0n-visual-search-mappings.html

" makes * and # work on visual mode too.
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

vmap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vmap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

" recursively vimgrep for word under cursor or selection if you hit leader-star

" use if ack not available
"nmap <leader>* :execute 'noautocmd vimgrep /\V' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g') . '/ **'<CR>
"vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd vimgrep /' . @/ . '/ **'<CR>

" use if ack available
nmap <leader>* :execute 'noautocmd Ack ' . substitute(escape(expand("<cword>"), '\'), '\n', '\\n', 'g')<CR>
vmap <leader>* :<C-u>call <SID>VSetSearch()<CR>:execute 'noautocmd Ack ' . @/<CR>

"
"


" Begin Vundle
set rtp+=~/.vim/bundle/Vundle.vim/ " set the runtime path to include Vundle and initialize
call vundle#begin()

Plugin 'gmarik/Vundle.vim' " let Vundle manage Vundle, required

Plugin 'kien/ctrlp.vim.git'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

Plugin 'tpope/vim-fugitive.git'

" Plugin 'avakhov/vim-yaml'

Plugin 'scrooloose/nerdtree'
map <Leader>t :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.o$']

"Plugin 'bronson/vim-visual-star-search'

" on ubuntu precise, ack-grep is an older version so have to override default
" arguments
let g:ack_default_options = " -H --nocolor --nogroup --column -a"
Plugin 'mileszs/ack.vim'
nnoremap <Leader>s :Ack 

" for newer versions of ack, use this in .vimrc.local:
" let g:ack_default_options = " -s -H --nocolor --nogroup --column"

call vundle#end()
" end Vundle

filetype plugin indent on

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
