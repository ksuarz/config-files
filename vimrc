""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc - Vim configuration settings
" Kyle Suarez
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                " Vim behavior as opposed to vi
let g:is_silent=1               " Controls whether some functions show output

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
        call Talk("No tabs to expand.")
    endtry
endfunction

" Toggles curly brace autocompletion.
function! AutocompleteBraces()
    " TODO some systems don't like maparg
    if !maparg("{<CR>")
        inoremap {  {}<LEFT>
        inoremap {{ {
        inoremap {<CR>  {<CR>}<ESC>ko
        inoremap {} {}
        call Talk("Brace completion turned on.")
    else
        iunmap {
        iunmap {{
        iunmap {<CR>
        iunmap {}
        call Talk("Brace completion turned off.")
    endif
endfunction

" Toggles quote autocompletion on and off. Mostly for Python
function! AutocompleteQuotes()
    if !maparg("n'")
        " These can get annoying; uncomment to activate.
"        inoremap '  ''<LEFT>
"        inoremap n' n'
"        inoremap s' s'
"        inoremap 's 's
"        inoremap '' ''
"        inoremap "  ""<LEFT>
"        inoremap "" ""
        inoremap """<CR>    """<CR>"""<ESC>ko
        inoremap '''<CR>    '''<CR>'''<ESC>ko
        call Talk("Quote completion turned on.")
    else
"        iunmap '
"        iunmap n'
"        iunmap s'
"        iunmap 's
"        iunmap ''
"        iunmap "
"        iunmap ""
        iunmap """<CR>
        iunmap '''<CR>
        call Talk("Quote completion turned off.")
    endif
endfunction

" Show us when lines go over 80 characters in length.
function! ShowLongLines()
    try
        /\%>80v.\+
    catch
        call Talk("All lines are within 80 characters.")
        return
    endtry
    match ErrorMsg '\%>80v.\+'
endfunction

" Controls whether or not we say something for custom functions.
function! BeQuiet()
    if exists("g:is_silent") && g:is_silent!=0
        let g:is_silent=0
        echo "Shutting up now."
    endif
endfunction

" Utility method for printing info back.
function! Talk(message)
    if exists("g:is_silent") && g:is_silent==1
        echo a:message
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom keybindings and mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatic tab expansion
nnoremap <LEADER>exp    :call ExpandTabs()<CR>

" Show long lines
nnoremap <LEADER>long   :call ShowLongLines()<CR>

" Select all (ditched the C-a)
nnoremap <LEADER>all    ggVG

" More common mappings.
nnoremap <C-z>  :undo<CR>
nnoremap <C-y>  :redo<CR>
nnoremap <C-s>  :w<CR>

" Reload config file
nnoremap <C-r> :source ~/.vimrc<CR>

" Clear search and match highlighting
nnoremap <SPACE>    :match none<CR>:nohlsearch<CR>

" Adding, deleting, and moving lines around
nnoremap <C-d>  dd
nnoremap <C-f>  o<ESC>
nnoremap <C-UP>    :m -2<CR>
nnoremap <C-DOWN>  :m +1<CR>

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
" General filetype detection
autocmd! BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile Makefile,makefile,*.mak set filetype=make
autocmd BufRead,BufNewFile *.py silent call AutocompleteQuotes()
autocmd BufRead,BufNewFile *.java,*.c silent call AutocompleteBraces()
autocmd BufRead,BufNewFile *.c compiler gcc

" Create these files from templates
" TODO fix the template files
if filereadable(glob("~/.vim/templates/C.vim"))
    autocmd BufNewFile *.ino source "~/.vim/templates/Arduino.vim"
    autocmd BufNewFile *.c source "~/.vim/templates/C.vim"
    autocmd BufNewFile *.cpp source "~/.vim/templates/C++.vim"
    autocmd BufNewFile *.html source "~/.vim/templates/HTML.vim"
    autocmd BufNewFile *.java source "~/.vim/templates/Java.vim"
    autocmd BufNewFile *.mkd,*.md source "~/.vim/templates/Markdown.vim"
    au BufNewFile Makefile,makefile,*.mak so "~/.vim/templates/Makefile.vim"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
set background=dark
colorscheme evening

" Pathogen, from https://github.com/tpope/vim-pathogen 
if filereadable(glob("~/.vim/autoload/pathogen.vim"))
    execute pathogen#infect()       
endif

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
filetype indent on              " Indent based on detected filetype
filetype plugin on              " Allow filetype plugins
syntax on                       " Syntax highlighting
set showcmd                     " Shows the commands you type at the bottom
set hlsearch                    " Search highlighting
set incsearch                   " Instant searching
set cursorline                  " Highlight current line
set ignorecase
set smartcase                   " I believe it's case sensitive only sometimes
set nowrap                      " No line wrapping
set backspace=indent,eol,start  " Backspace works intuitively
set autoindent
set nostartofline               " Movements don't auto-jump to line start
set ruler
set confirm                     " Confirm quit if dirty and :q is used
set mouse=a                     " Use the mouse in all modes
set number                      " Show line numbers
set nohidden                    " No hiding buffers after they're abandoned
set notimeout                   " Don't time out on mappings
set ttimeout                    " Quick timeout on keycodes
set ttimeoutlen=100
set autoread                    " Reload the file if changed from outisde
