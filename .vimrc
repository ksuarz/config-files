""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc - Vim configuration settings
" Kyle Suarez
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                " Vim behavior as opposed to vi

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function Definitions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Changes all the tab-width settings at once.
function! SetTab(tabwidth)
    let s:width=a:tabwidth
    let &shiftwidth=s:width
    let &tabstop=s:width
    let &softtabstop=s:width
endfunction

" Replace all tabs with four spaces in the current file.
function! ExpandTabs()
    try
        %s/\t/    /g
    catch
        " Ignore the error if the pattern does not exist.
    endtry
endfunction

" Toggles curly brace autocompletion.
function! AutocompleteBraces()
    if !maparg("{<CR>")
        " Completion for curly braces
        inoremap {  {}<LEFT>
        inoremap {{ {
        inoremap {<CR>  {<CR>}<ESC>ko
        inoremap {} {}
        echo "Brace completion turned on."
    else
        iunmap {
        iunmap {{
        iunmap {<CR>
        iunmap {}
        echo "Brace completion turned off."
    endif
endfunction


" Toggles quote autocompletion on and off. Mostly for Python
function! AutocompleteQuotes()
    if !maparg("n'")
        " Completion for single and double quotes
        inoremap '  ''<LEFT>
        inoremap n' n'
        inoremap s' s'
        inoremap 's 's
        inoremap '' ''
        inoremap "  ""<LEFT>
        inoremap "" ""
        inoremap """<CR>    """<CR>"""<ESC>ko
        echo "Quote completion turned on."
    else
        iunmap '
        iunmap n'
        iunmap s'
        iunmap 's
        iunmap ''
        iunmap "
        iunmap ""
        iunmap """<CR>
        echo "Quote completion turned off."
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom keybindings and mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reload config file
nnoremap <C-r> :source ~/.vimrc<CR>

" Shift-E to expand all tabs
nnoremap <C-E> :call ExpandTabs()<CR>

" More common mappings. Will need something to pass on C-a in screen or tmux
nnoremap <C-z>  :undo<CR>
nnoremap <C-y>  :redo<CR>
nnoremap <C-s>  :w<CR>
nnoremap <C-a>  ggVG

" Search Hilightning (SPACE to clear highlighting)
nnoremap <SPACE>    :nohlsearch<CR>

" Adding, deleting, and moving lines around
nnoremap <C-d>  dd
" nnoremap <C-S-D>  o<ESC>
nnoremap <C-UP>    :m -2<CR>
nnoremap <C-DOWN>  :m +1<CR>

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
" General filetype detection
" TODO add markdown syntax file
autocmd! BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile Makefile,makefile,*.mak set filetype=make
autocmd BufRead,BufNewFile *.py silent call AutocompleteQuotes()
autocmd BufRead,BufNewFile *.java,*.c silent call AutocompleteBraces()

" Create these files from templates
"if filereadable("~/.vim/templates/C.vim")
"    autocmd BufNewFile *.ino source "~/.vim/templates/Arduino.vim"
"    autocmd BufNewFile *.c source "~/.vim/templates/C.vim"
"    autocmd BufNewFile *.cpp source "~/.vim/templates/C++.vim"
"    autocmd BufNewFile *.html source "~/.vim/templates/HTML.vim"
"    autocmd BufNewFile *.java source "~/.vim/templates/Java.vim"
"    autocmd BufNewFile *.mkd,*.md source "~/.vim/templates/Markdown.vim"
"    au BufNewFile Makefile,makefile,*.mak so "~/.vim/templates/Makefile.vim"
"endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
set background=dark
colorscheme evening

" Command line completion
set wildmenu
set wildignore=*.o,*.jpg,*.png,*.gif

" Indentation
set expandtab                   " Spaces instead of tabs
call SetTab(4)                  " 4 spaces to a tab

" Turn on brace completion
if !maparg("{<CR>")
    silent call AutocompleteBraces()
endif

" More settings
filetype indent plugin on       " Indent based on detected filetype
syntax on                       " Syntax highlighting
set showcmd                     " Shows the commands you type at the bottom
set hlsearch                    " Search highlighting
set cursorline                  " Highlight current line
set ignorecase
set smartcase                   " I believe it's case sensitive only sometimes
set nowrap                      " No line wrapping
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
