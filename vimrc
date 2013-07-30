""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc - Vim configuration settings
" Kyle Suarez
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                " Vim behavior as opposed to vi
let g:is_silent=0               " Controls whether some functions show output

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function Definitions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Changes all the tab-width settings at once.
function! SetTab(tabwidth)
    let l:width=a:tabwidth
    let &shiftwidth=l:width
    let &tabstop=l:width
    let &softtabstop=l:width
endfunction

" Replace all tabs with four spaces in the current file.
function! ExpandTabs()
    try
        %s/\t/    /g
    catch E486
        call Talk('No tabs to expand.')
    endtry
endfunction

" Toggles curly brace autocompletion.
function! AutocompleteBraces()
    if maparg('{<CR>', 'i') == ''
        inoremap {  {}<LEFT>
        inoremap {{ {
        inoremap {<CR>  {<CR>}<ESC>ko
        inoremap {} {}
        call Talk('Brace completion turned on.')
    else
        silent! iunmap {
        silent! iunmap {{
        silent! iunmap {<CR>
        silent! iunmap {}
        call Talk('Brace completion turned off.')
    endif
endfunction

" Toggles quote autocompletion for Python long strings. You can add more
" general quote completion, but it tends to get very annoying.
function! AutocompleteQuotes()
    if maparg('"""<CR>', 'i') == ''
        inoremap """<CR>    """<CR>"""<ESC>ko
        inoremap '''<CR>    '''<CR>'''<ESC>ko
        call Talk('Quote completion turned on.')
    else
        silent! iunmap """<CR>
        silent! iunmap '''<CR>
        call Talk('Quote completion turned off.')
    endif
endfunction

" Turns on and off intuitive j/k movement when in wrap mode.
function! WrapMode(arg)
    if a:arg == 'off' || a:arg == '0'
        let &wrap=0
        silent! unmap j
        silent! unmap k
        call Talk('Wrap mode turned off.')
    elseif a:arg == 'on' || a:arg == '1'
        let &wrap=1
        noremap j gj
        noremap k gk
        call Talk('Smart wrap mode turned on.')
    else
        call Talk('Argument must be either "off" or "on".')
    endif
endfunction

" Show us when lines go over 80 characters in length.
function! ShowLongLines()
    try
        /\%>80v.\+
        match ErrorMsg '\%>80v.\+'
    catch E486
        call Talk('All lines are within 80 characters.')
    endtry
endfunction

" Displays trailing whitespace except for blank lines.
function! ShowTrailingWhitespace()
    try
        /\s\+$
        match ErrorMsg '\s\+$'
    catch E486
        call Talk('No trailing whitespace.')
    endtry
endfunction

" Forces some PEP8 style guidelines. It will probably get annoying
function! PEP8()
    if &filetype == 'python'
        %s/"/'/ge
        set textwidth=79
        set colorcolumn=79
        inoremap '''<CR> '''<CR>'''<ESC>ko
        call Talk('PEP8 compliance activated.')
    else
        set textwidth=0
        set colorcolumn=0
        silent! iunmap '''<CR>
        call Talk('Not a Python file. PEP8 deactivated.')
    endif
endfunction

" Controls whether or not we say something for custom functions.
function! BeQuiet()
    if exists('g:is_silent') && g:is_silent!=1
        let g:is_silent=1
        echo 'Shutting up now.'
    endif
endfunction

" Utility method for printing info back.
function! Talk(message)
    if exists('g:is_silent') && g:is_silent==0
        echo a:message
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom keybindings and mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets the value of <LEADER> (default is the backslash)
let mapleader = ','

" Common mappings
map Y y$
nnoremap <C-z>  :undo<CR>
nnoremap <C-y>  :redo<CR>
nnoremap <LEADER>s  :w<CR>
nnoremap <LEADER>a  ggVG

" Reload config file
nnoremap <C-r> :source ~/.vimrc<CR>
"
" Clear search and match highlighting
nnoremap <SPACE> :match none<CR>:nohlsearch<CR>

" Find annoying things in code
nnoremap <LEADER>l  :call ShowLongLines()<CR>
nnoremap <LEADER>w  :call ShowTrailingWhitespace()<CR>

" Adding, deleting, and moving lines around
nnoremap <LEADER>d  dd
nnoremap <LEADER>f  o<ESC>
nnoremap <LEADER>j  :m +1<CR>
nnoremap <LEADER>k  :m -2<CR>

" Automatic block commenting and uncommenting
vnoremap <LEADER>#  :normal 0i#<CR>
vnoremap <LEADER>/  :normal 0i//<CR>
vnoremap <LEADER>"  :normal 0i"<CR>
vnoremap <LEADER>x  :normal 0x<CR>
vnoremap <LEADER>2x :normal 02x<CR>

" Automatic matching completion for...
" Square brackets
inoremap [  []<LEFT>
inoremap [[ [
inoremap [<CR>  [<CR>]<ESC>ko
inoremap [] []

" Parentheses
inoremap (  ()<LEFT>
inoremap (( (
inoremap (<CR>  (<CR>)<ESC>ko
inoremap () ()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" First, clear out old autocommands
autocmd!

" Do something when detecting particular filetypes
autocmd BufRead,BufNewFile *.c compiler gcc
autocmd BufRead,BufNewFile *.c set cindent
autocmd BufRead,BufNewFile *.ino set filetype=java
autocmd BufRead,BufNewFile *.md,*.mkd set filetype=ghmarkdown
autocmd BufRead,BufNewFile *.py silent call AutocompleteQuotes()
autocmd BufRead,BufNewFile Makefile*,makefile*,*.mak set filetype=make

" Create these files from templates
if filereadable(glob('~/.vim/templates/template.c'))
    au BufNewFile Makefile*,makefile*,*.mak 0r ~/.vim/templates/template.make
    autocmd BufNewFile *.c 0r ~/.vim/templates/template.c
    autocmd BufNewFile *.cpp 0r ~/.vim/templates/template.cpp
    autocmd BufNewFile *.html 0r ~/.vim/templates/template.html
    autocmd BufNewFile *.ino 0r ~/.vim/templates/template.ino
    autocmd BufNewFile *.java 0r ~/.vim/templates/template.java
    autocmd BufNewFile *.mkd,*.md 0r ~/.vim/templates/template.mkd
    autocmd BufNewFile *.py 0r ~/.vim/templates/template.py
    autocmd BufNewFile *.sh 0r ~/.vim/templates/template.sh
    autocmd BufNewFile *.spec 0r ~/.vim/templates/template.spec
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
set background=dark
colorscheme evening

" Pathogen, from https://github.com/tpope/vim-pathogen
if filereadable(glob('~/.vim/autoload/pathogen.vim'))
    execute pathogen#infect()
endif

" Command line completion
set wildmenu
set wildignore=*.o,*.jpg,*.png,*.gif,*.pyc,*.tar,*.gz,*.zip

" Indentation
set expandtab                   " Spaces instead of tabs
set smarttab                    " Intelligent tab insertion/deletion
call SetTab(4)                  " 4 spaces to a tab

" Turn on brace completion
if maparg('{<CR>', 'i') == ''
    silent call AutocompleteBraces()
endif

" More settings
filetype indent on              " Indent based on detected filetype
filetype plugin on              " Allow filetype plugins
set autoindent
set autoread                    " Reload the file if changed from outisde
set backspace=indent,eol,start  " Backspace works intuitively
set confirm                     " Confirm quit if dirty and :q is used
set cursorline                  " Highlight current line
set hlsearch                    " Search highlighting
set ignorecase
set mouse=a                     " Use the mouse in all modes
set nohidden                    " No hiding buffers after they're abandoned
set nostartofline               " Movements don't auto-jump to line start
set nowrap                      " No line wrapping
set number                      " Show line numbers
set ruler
set showcmd                     " Shows incomplete commands
set smartcase                   " Case sensitive depending on search
set smartindent                 " Adds indents based on context
set timeout                     " Time out on both mappings and keycodes
set timeoutlen=200              " 200ms time-out length
syntax on                       " Syntax highlighting
