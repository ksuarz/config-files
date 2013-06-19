set nocompatible
filetype indent plugin on
syntax on

" General Settings
colo evening
set wildmenu
set showcmd
set hlsearch

" Lines and Searching
set cursorline
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set confirm
set visualbell
set mouse=a
set number
set notimeout ttimeout ttimeoutlen=200

" Indentation
set shiftwidth=4
set tabstop=4

" Search Hilightning
map  <F5> :set hls!<CR>
imap <F5> <ESC>:set hls!<CR>a
vmap <F5> <ESC>:set hls!<CR>gv
