""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc - Vim configuration settings
" Kyle Suarez
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                " Vim behavior as opposed to vi
let g:host=system("hostname")   " Get the name of the current host
let g:is_silent=0               " Controls whether some functions show output
let g:tab_width=4               " Preferred tab width

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function Definitions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggles curly brace autocompletion.
function! AutocompleteBraces()
    if maparg("{<CR>", "i") == ""
        inoremap {  {}<LEFT>
        inoremap {{ {
        inoremap {<CR>  {<CR>}<ESC>ko
        inoremap {} {}
        call Talk("Brace completion turned on.")
    else
        silent! iunmap {
        silent! iunmap {{
        silent! iunmap {<CR>
        silent! iunmap {}
        call Talk("Brace completion turned off.")
    endif
endfunction

" Toggles parenthesis and bracket autocompletion
function! AutocompleteParens()
    if maparg("(", "i") == ""
        inoremap [  []<LEFT>
        inoremap [[ [
        inoremap [<CR>  [<CR>]<ESC>ko
        inoremap [] []
        inoremap (  ()<LEFT>
        inoremap (( (
        inoremap (<CR>  (<CR>)<ESC>ko
        inoremap () ()
        call Talk("Bracket/parenthesis completion turned on.")
    else
        silent! iunmap [
        silent! iunmap [[
        silent! iunmap [<CR>
        silent! iunmap []
        silent! iunmap (
        silent! iunmap ((
        silent! iunmap (<CR>
        silent! iunmap ()
        call Talk("Bracket/parenthesis completion turned off.")
    endif
endfunction

" Controls whether or not we say something for custom functions.
function! BeQuiet()
    if exists("g:is_silent") && g:is_silent != 1
        let g:is_silent=1
        echomsg "Shutting up now."
    endif
endfunction

" Replace all tabs with spaces in the current file.
function! ExpandTabs()
    try
        %s/\t/\=repeat(" ", g:tab_width)/g
    catch E486
        call Talk("No tabs to expand.")
    endtry
endfunction

" Inserts a Markdown header line on the current line based on the line above
" with some hacky substitution magic.
function! InsertLine(char)
    let l:x=line(".")
    if l:x > 1
        let l:length=strlen(getline(l:x - 1))
        .s/^.*$/\=repeat(a:char, l:length)/g
    else
        call Talk("Can't insert a line here.")
    endif
endfunction

" Insert a \begin block
function! InsertTex()
    " Take what's typed on the current line and strip whitespace
    let l:line=getline(line("."))
    let l:cmd=substitute(l:line, '^\s*\(.\{-}\)\s*$', '\1', '')

    if strlen(l:cmd) > 0
        let l:block="\\begin{".l:cmd."}\r\\end{".l:cmd."}"
        .s/^.*$/\=l:block/g
        normal k
        normal o
    endif
endfunction

" Creates a new C file, either from template or based on a header file.
function! NewCFile()
    let l:headerfile=fnamemodify(@%, ":t:r").".h"
    if filereadable(l:headerfile)
        " Use the existing header file
        exec "read ".l:headerfile
        %s/^#.*$//ge
        %s/\n\n\n//ge
        %s/);/) {\r    \/\/ TODO\r}/ge
        normal ggO
        exec "normal i#include \"".l:headerfile."\""

    elseif filereadable(glob("~/.vim/templates/template.c"))
        " Make it from template
        read ~/.vim/templates/template.c
        normal ggdd5G
    endif
endfunction

" Creates an automatic C header file from a template.
function! NewHeaderFile()
    if filereadable(glob("~/.vim/templates/template.h"))
        read ~/.vim/templates/template.h
        let l:headername=toupper(fnamemodify(@%, ":t:r"))
        %s/$NAME/\=l:headername/ge
        normal ggdd3G
    endif
endfunction

" Does some cool stuff when you open a new Java file.
function! NewJavaFile()
    if filereadable(glob("~/.vim/templates/template.java"))
        read ~/.vim/templates/template.java
        let l:classname=fnamemodify(@%, ":t:r")
        %s/$CLASSNAME/\=l:classname/ge
        %s/$USERNAME/\=$USER/ge
        normal ggdd6G
    endif
endfunction

" Custom mappings for TeX files
function! NewTexFile()
    imapclear
    inoremap \[<CR> \[<CR>\]<ESC>ko
    inoremap " ``''<ESC>hi
    inoremap <C-b> <ESC>:call InsertTex()<CR>i
endfunction

" More cool stuff for Markdown and README files.
function! NewMarkdownFile()
    if filereadable(glob("~/.vim/templates/template.md"))
        read ~/.vim/templates/template.md
        let l:flags=(fnamemodify(@%, ":t:r") =~? "README" ? ":p:h:t" : ":t:r")
        let l:title=fnamemodify(@%, l:flags)
        let l:header=repeat("=", len(l:title))
        %s/$TITLE/\=l:title/ge
        %s/$HEADER/\=l:header/ge
        normal ggddG
    endif
endfunction

" Changes all the tab-width settings at once.
function! SetTab(tabwidth)
    let l:width=a:tabwidth
    let &shiftwidth=l:width
    let &softtabstop=l:width
endfunction

" Show us when lines go over 80 characters in length.
function! ShowLongLines()
    try
        /\%>80v.\+
        match ErrorMsg "\%>80v.\+"
    catch E486
        call Talk("All lines are within 80 characters.")
    endtry
endfunction

" Displays trailing whitespace except for blank lines.
function! ShowTrailingWhitespace()
    try
        /\s\+$
        match ErrorMsg "\s\+$"
    catch E486
        call Talk("No trailing whitespace.")
    endtry
endfunction

" Utility method for printing info back.
function! Talk(message)
    if exists("g:is_silent") && g:is_silent == 0
        echomsg a:message
    endif
endfunction

" Turns on and off intuitive j/k movement when in wrap mode.
function! WrapMode(opt)
    if a:opt == "off" || a:opt == "0"
        let &wrap=0
        silent! unmap j
        silent! unmap k
        call Talk("Wrap mode turned off.")
    elseif a:opt == "on" || a:opt == "1"
        let &wrap=1
        let &linebreak=1
        noremap j gj
        noremap k gk
        call Talk("Smart wrap mode turned on.")
    else
        call Talk("Argument must be either \"off\" or \"on\".")
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom keybindings and mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets the value of <LEADER> (default is the backslash)
let mapleader=" "

" Common mappings
map Y y$
nmap <C-z> :undo<CR>
nmap <C-y> :redo<CR>
nnoremap <LEADER>a ggVG

" Reload config file
nmap <LEADER>r :source ~/.vimrc<CR>

" Yanking and pasting to the clipboard
noremap <LEADER>y "+y
noremap <LEADER>p "+p

" Clear search and match highlighting
nmap <LEADER><LEADER> :match none<CR>:nohlsearch<CR>

" Find annoying things in code
nmap <LEADER>l :call ShowLongLines()<CR>
nmap <LEADER>w :call ShowTrailingWhitespace()<CR>

" Adding, deleting, and moving lines around
nmap <LEADER>- :call InsertLine("-")<CR>
nmap <LEADER>j :move +1<CR>
nmap <LEADER>k :move -2<CR>
nnoremap <LEADER><CR> o<ESC>

" Automatic block commenting and uncommenting
vnoremap <LEADER>#  :normal 0i#<CR>
vnoremap <LEADER>/  :normal 0i//<CR>
vnoremap <LEADER>"  :normal 0i"<CR>
vnoremap <LEADER>x  :normal 0x<CR>
vnoremap <LEADER>2x :normal 02x<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do something when detecting particular filetypes.
augroup detect_filetype
    autocmd!
    autocmd BufRead,BufNewFile *.c compiler gcc
    autocmd BufRead,BufNewFile *.go set filetype=go
    autocmd BufRead,BufNewFile *.go set textwidth=0
    autocmd BufRead,BufNewFile *.ino set filetype=java
    autocmd BufRead,BufNewFile *.json set filetype=javascript
    autocmd BufRead,BufNewFile *.mak,[Mm]akefile* set filetype=make
    autocmd BufRead,BufNewFile *.md,*.mkd set filetype=ghmarkdown
    autocmd BufRead,BufNewFile *.sls silent call SetTab(2)
    autocmd BufRead,BufNewFile *.tex silent! call NewTexFile()
    autocmd BufRead,BufNewFile *.txt silent call WrapMode("on")
    autocmd BufRead,BufNewFile README,Readme set filetype=markdown
augroup end

" Create these files from templates.
let s:template="~/.vim/templates/template."
if glob("~/.vim/templates/") != ""
    " Load a basic template based off of the file extension
    augroup simple_templates
        autocmd!
        autocmd BufNewFile *.cpp,*.html,*.ino,*.php,*.py,*.sh,*.spec,*.tex
                    \ silent! exe "0r ".s:template.fnamemodify(@%, ":e")
    augroup end

    " Does more than just render the template, like calling a function
    augroup super_templates
        autocmd!
        autocmd BufNewFile *.c silent! call NewCFile()
        autocmd BufNewFile *.cc silent! exe "0r ".s:template."cpp"
        autocmd BufNewFile *.h silent! call NewHeaderFile()
        autocmd BufNewFile *.htm silent! exe "0r ".s:template."html"
        autocmd BufNewFile *.java silent! call NewJavaFile()
        autocmd BufNewFile *.mkd,*.md silent! call NewMarkdownFile()
        autocmd BufNewFile *.rst silent! call NewMarkdownFile()
        autocmd BufNewFile README,Readme silent! call NewMarkdownFile()
        autocmd BufNewFile [Mm]akefile* silent! exe "0r ".s:template."make"
    augroup end
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
set background=dark
colorscheme solarized

" Wild menu settings
set wildmenu
set wildignore=*.o,*.jpg,*.png,*.gif,*.pyc,*.tar,*.gz,*.zip,*.class,*.pdf

" Indentation
set expandtab                   " Spaces instead of tabs
set smarttab                    " Intelligent tab insertion/deletion
call SetTab(g:tab_width)        " By default, four spaces to a tab

" Turn on our completions
if maparg("{<CR>", "i") == ""
    silent call AutocompleteBraces()
endif
if maparg("(", "i") == ""
    silent call AutocompleteParens()
endif

" More settings
filetype indent on              " Indent based on detected filetype
filetype plugin on              " Allow filetype plugins
set autoindent
set autoread                    " Reload the file if changed from outside
set backspace=indent,eol,start  " Backspace works intuitively
set confirm                     " Confirm quit if dirty
set cursorline                  " Highlight current line
set hidden                      " Hide buffers after they're abandoned
set hlsearch                    " Search highlighting
set ignorecase
set mouse=a                     " Use the mouse in all modes
set nofoldenable                " Open folds; use `set foldenable` to close
set nosmartindent               " Smart indent is annoying when typing `#`
set nostartofline               " Movements don't auto-jump to line start
set noswapfile                  " Goodbye .swp
set nowrap                      " No line wrapping
set number                      " Show line numbers
set ruler
set showcmd                     " Shows incomplete commands
set smartcase                   " Case sensitive depending on search
set spelllang=en_us             " Sets language if `set spell` is on
set splitbelow                  " Horizontal split splits below
set splitright                  " Vertical split splits right
set t_Co=256                    " Use 256 colors
set tabstop=8                   " For files tabbed by others
set textwidth=80                " Stay within 80 characters
set timeout                     " Time out on both mappings and keycodes
set timeoutlen=300              " 300ms time-out length
syntax enable                   " Syntax highlighting