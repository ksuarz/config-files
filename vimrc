""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc - Vim configuration settings
" Kyle Suarez
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                " Vim behavior as opposed to vi

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function Definitions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Replace all tabs with spaces in the current file.
function! ExpandTabs()
    try
        %s/\t/\=repeat(" ", &softtabstop)/g
    catch E486
        echomsg "No tabs to expand."
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
        echomsg "Can't insert a line here."
    endif
endfunction

" Insert a \begin block
function! InsertTex()
    " Separate leading indentation and the command
    let l:line=getline(line("."))
    let l:cmd=substitute(l:line, '^\s*\(.\{-}\)\s*$', '\1', '')
    let l:ws=substitute(l:line, '^\(\s*\).\{-}\s*$', '\1', '')

    if strlen(l:cmd) > 0
        let l:block=l:ws."\\begin{".l:cmd."}\r".l:ws."\\end{".l:cmd."}"
        .s/^.*$/\=l:block/g
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
    inoremap <C-b> <ESC>:call InsertTex()<CR>O
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

" Show us when lines go over 80 characters in length.
function! ShowLongLines()
    try
        /\%>80v.\+
        match ErrorMsg "\%>80v.\+"
    catch E486
        echomsg "All lines are within 80 characters."
    endtry
endfunction

" Deletes all trailing whitespace.
function! DeleteTrailingWhitespace()
    try
        %s/\s\+$//g
    catch E486
        echomsg "No trailing whitespace."
    endtry
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

" Mappings for braces and the like
inoremap {<CR>  {<CR>}<ESC>ko
inoremap [<CR>  [<CR>]<ESC>ko
inoremap (<CR>  (<CR>)<ESC>ko

" Reload config file
nmap <LEADER>r :source ~/.vimrc<CR>

" Yanking and pasting to the clipboard
noremap <LEADER>y "+y
noremap <LEADER>p "+p

" Clear search and match highlighting
nmap <LEADER><LEADER> :match none<CR>:nohlsearch<CR>

" Find annoying things in code
nmap <LEADER>l :call ShowLongLines()<CR>
nmap <LEADER>w :call DeleteTrailingWhitespace()<CR>

" Manipulating lines
nmap <LEADER>- :call InsertLine("-")<CR>
nnoremap <LEADER><CR> o<ESC>

" Automatic block commenting and uncommenting
vnoremap <LEADER>#  :normal 0i#<CR>
vnoremap <LEADER>/  :normal 0i//<CR>
vnoremap <LEADER>x  :normal 0x<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do something when detecting particular filetypes.
augroup detect_filetype
    autocmd!
    autocmd BufRead,BufNewFile *.go set filetype=go
    autocmd BufRead,BufNewFile *.ino set filetype=java
    autocmd BufRead,BufNewFile *.json set filetype=javascript
    autocmd BufRead,BufNewFile *.mak,[Mm]akefile* set filetype=make
    autocmd BufRead,BufNewFile *.md,*.mkd set filetype=ghmarkdown
    autocmd BufRead,BufNewFile *.page set filetype=xml
    autocmd BufRead,BufNewFile *.tex silent! call NewTexFile()
    autocmd BufRead,BufNewFile README,Readme set filetype=markdown
augroup end

" Change indentation and text settings based on filetype
augroup filetype_indentation
    autocmd FileType c setl shiftwidth=3 tabstop=3
    autocmd FileType go set textwidth=0
    autocmd FileType html setl shiftwidth=2 tabstop=2 textwidth=0
    autocmd FileType xml setl shiftwidth=2 tabstop=2 textwidth=0
augroup end

" Create these files from templates.
let s:template="~/.vim/templates/template."
if glob("~/.vim/templates/") != ""
    " Load a basic template based off of the file extension
    augroup simple_templates
        autocmd!
        autocmd BufNewFile *.cpp,*.html,*.php,*.py,*.page,*.sh,*.spec,*.tex
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
colorscheme solarized           " Solarized
let g:solarized_termtrans=1     " Use a completely-transparent background

" Wild menu settings
set wildmenu
set wildignore=*.o,*.jpg,*.png,*.gif,*.pyc,*.tar,*.gz,*.zip,*.class,*.pdf

" Indentation
set autoindent                  " Indent based on the line before
set expandtab                   " Spaces instead of tabs
set nosmartindent               " Smart indent is annoying when typing `#`
set shiftwidth=4                " Four columns when indenting with > or <
set smarttab                    " Delete `shiftwidth` amount of spaces
set softtabstop=4               " When we hit tab, use four columns
set tabstop=8                   " Render existing tabs in text as eight columns

" More settings
filetype indent on              " Indent based on detected filetype
filetype plugin on              " Allow filetype plugins
set autoread                    " Reload the file if changed from outside
set backspace=indent,eol,start  " Backspace works intuitively
set confirm                     " Confirm quit if dirty
set cursorline                  " Highlight current line
set hidden                      " Hide buffers after they're abandoned
set hlsearch                    " Search highlighting
set ignorecase
set mouse=a                     " Use the mouse in all modes
set nofoldenable                " Open folds; use `set foldenable` to close
set nostartofline               " Movements don't auto-jump to line start
set noswapfile                  " Goodbye .swp
set nowrap                      " No line wrapping
set number                      " Show line numbers
set ruler
set showcmd                     " Shows incomplete commands
set smartcase                   " Case sensitive depending on search
set spell                       " Use spell checking
set spelllang=en_us             " Sets language if `set spell` is on
set splitbelow                  " Horizontal split splits below
set splitright                  " Vertical split splits right
set t_Co=256                    " Use 256 colors
set textwidth=80                " Stay within 80 characters
set timeout                     " Time out on both mappings and keycodes
set timeoutlen=300              " 300ms time-out length
syntax enable                   " Syntax highlighting
