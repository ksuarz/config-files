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
    catch
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
        iunmap {
        iunmap {{
        iunmap {<CR>
        iunmap {}
        call Talk('Brace completion turned off.')
    endif
endfunction

" Toggles quote autocompletion for Python long strings.
function! AutocompleteQuotes()
    if maparg('"""<CR>', 'i') == ''
        inoremap """<CR>    """<CR>"""<ESC>ko
        inoremap '''<CR>    '''<CR>'''<ESC>ko
        call Talk('Quote completion turned on.')
    else
        iunmap """<CR>
        iunmap '''<CR>
        call Talk('Quote completion turned off.')
    endif
endfunction

" Show us when lines go over 80 characters in length.
function! ShowLongLines()
    try
        /\%>80v.\+
        match ErrorMsg '\%>80v.\+'
    catch
        call Talk('All lines are within 80 characters.')
    endtry
endfunction

" Displays trailing whitespace except for blank lines.
function! ShowTrailingWhitespace()
    try
        /\s\+$
        match ErrorMsg '\s\+$'
    catch
        call Talk('No trailing whitespace.')
    endtry
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
vnoremap <LEADER>#  :norm 0i#<CR>
vnoremap <LEADER>/  :norm 0i//<CR>
vnoremap <LEADER>"  :norm 0i"<CR>
vnoremap <LEADER>x  :norm 0x<CR>
vnoremap <LEADER>2x :norm 02x<CR>

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
autocmd BufRead,BufNewFile *.md,*.mkd set filetype=markdown
autocmd BufRead,BufNewFile Makefile,makefile,*.mak set filetype=make
autocmd BufRead,BufNewFile *.py silent call AutocompleteQuotes()
autocmd BufRead,BufNewFile *.c compiler gcc
autocmd BufRead,BufNewFile *.c set cindent
autocmd BufRead,BufNewFile *.ino set filetype=java

" Create these files from templates
if filereadable(glob('~/.vim/templates/c.template'))
    autocmd BufNewFile *.c 0r ~/.vim/templates/c.template
    autocmd BufNewFile *.ino 0r ~/.vim/templates/arduino.template
    autocmd BufNewFile *.cpp 0r ~/.vim/templates/c++.template
    autocmd BufNewFile *.html 0r ~/.vim/templates/html.template
    autocmd BufNewFile *.java 0r ~/.vim/templates/java.template
    autocmd BufNewFile *.mkd,*.md 0r ~/.vim/templates/markdown.template
    au BufNewFile Makefile,makefile,*.mak 0r ~/.vim/templates/make.template
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
set nohidden                    " No hiding buffers after they're abandoned
set nostartofline               " Movements don't auto-jump to line start
set nowrap                      " No line wrapping
set number                      " Show line numbers
set mouse=a                     " Use the mouse in all modes
set ruler
set showcmd                     " Shows incomplete commands
set smartcase                   " Case sensitive depending on search
set smartindent                 " Adds indents based on context
set timeout                     " Time out on both mappings and keycodes
set timeoutlen=200              " 200ms time-out length
syntax on                       " Syntax highlighting
