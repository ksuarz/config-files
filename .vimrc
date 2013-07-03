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

" Changes all the tab-width settings at once.
function! SetTab (tabwidth)
    let s:width=a:tabwidth
    let &shiftwidth=s:width
    let &tabstop=s:width
    let &softtabstop=s:width
endfunction
 
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
call SetTab(4)

" Shortcut for editing .vimrc and .gvimrc
nnoremap <silent> <LEADER>vimrc     :split ~/.vimrc<CR>
nnoremap <silent> <LEADER>vvimrc    :vsplit ~/.vimrc<CR>
nnoremap <silent> <LEADER>gvimrc    :split ~/.gvimrc<CR>
nnoremap <silent> <LEADER>vgvimrc   :vsplit ~/.gvimrc<CR>

" Search Hilightning (SPACE to clear highlighting)
nnoremap <SPACE>    :noh<CR>

" Automatic bracket completion
inoremap {  {}<LEFT>
inoremap {{ {
inoremap {<CR>  {<CR>}<ESC>ko
inoremap {} {}

" Handy Select-All (\a)
nnoremap <LEADER>a ggVG

" Replace all tabs with four spaces in the current file.
function! ExpandTabs ()
    %s/\t/    /g
endfunction
