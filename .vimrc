" Start-up
set nocompatible                " Vim behavior as opposed to vi
filetype indent plugin on       " Indent based on detected filetype
syntax on                       " Syntax highlighting

" Backup
"set backup
"set backupdir=~/.vim/backup
"set directory=~/.vim/tmp

" Colors
set background=dark
colo evening

" General Settings
set wildmenu
set showcmd                     " Shows the commands you type at the bottom
set hlsearch                    " Search highlighting
set cursorline                  " Highlight current line
set ignorecase
set smartcase
set backspace=indent,eol,start  " Backspace works intuitively
set autoindent
set nostartofline               " Movements don't auto-jump to line start
set ruler
set confirm                     " Confirm quit if dirty and :q is used
set visualbell                  " Flash instead of beep
set mouse=a                     " Use the mouse in all modes
set number                      " Show line numbers
set nohidden                    " No hiding buffers after they're abandoned
compiler gcc                    " gcc by default

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

fu! PythonConfig(tabwidth)
    let width=a:tabwidth
    set expandtab
    set shiftwidth=width
    set tabstop=width
endfunction
