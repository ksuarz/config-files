" Start-up
set nocompatible
filetype indent plugin on
syntax on

" Colors
set background=dark
colo solarized

" Lines, Searching, Other General Settings
set wildmenu
set showcmd
set hlsearch
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
set nohidden
compiler gcc

" Indentation
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Shortcut for editing .vimrc and .gvimrc
nnoremap <silent> <LEADER>vimrc     :e ~/.vimrc<CR>
nnoremap <silent> <LEADER>svimrc    :vsplit ~/.vimrc<CR>
nnoremap <silent> <LEADER>gvimrc    :e ~/.gvimrc<CR>
nnoremap <silent> <LEADER>sgvimrc   :vsplit ~/.gvimrc<CR>

" Search Hilightning
nnoremap <SPACE>    :noh<CR>

" Automatic bracket completion
inoremap {  {}<LEFT>
inoremap {{ {
inoremap {<CR>  {<CR>}<ESC><UP>o
inoremap {} {}

" Handy Select-All
nnoremap <LEADER>a ggVG
