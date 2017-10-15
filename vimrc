""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc - Vim configuration settings
" Kyle Suarez
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                " Vim behavior as opposed to vi

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'wincent/command-t'
Plugin 'majutsushi/tagbar'

call vundle#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function Definitions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run clang-format on the current file.
function! ClangFormat()
    if &ft == "cpp"
        let cursor=getpos(".")
        %!clang-format -style=file
        call setpos(".", cursor)
    endif
endfunction

" Edit the current buffer in vimdiff mode, comparing changes since the last Git commit.
function! DiffGit()
    let l:fileName=expand("%:p")

    " If Git detects no changes, bail early.
    let l:throwaway=system("git diff --exit-code -s -- ".l:fileName)
    if v:shell_error == 0
        echomsg "No changes since last commit."
        return
    endif

    " Save information about the current buffer.
    let l:fileType=&filetype
    let l:splitRight=&splitright

    " Put this buffer into diff mode, then open a new scratch pane to the left.
    diffthis
    setlocal nosplitright
    vnew

    " Find the state of the file at the current Git HEAD and apply a patch to match that state.
    exec "%!git diff ".l:fileName."| patch -p 1 -Rs -o /dev/stdout"

    " Put the new buffer in read-only diff mode.
    diffthis
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile readonly
    exec "setlocal filetype=".l:fileType

    " Restore the original splitright setting.
    if l:splitRight
        setlocal splitright
    endif
endfunction

" Diff the contents of the current buffer with the file on disk and display a unified diff in a
" scratch pane.
function! DiffSaved()
    " If the modified flag isn't set, bail early.
    if !&modified
        echomsg "No changes."
        return
    endif

    " Copy the contents of this buffer and throw it into a scratch buffer.
    %y
    new
    normal Vp

    " Diff the contents of the scratch buffer with the file on disk.
    silent %! diff -u # -
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile readonly filetype=diff
    silent file diff
endfunction

" Replace all tabs with spaces in the current file.
function! ExpandTabs()
    let cursor = getpos(".")
    let query = getreg('/')
    try
        %s/\t/\=repeat(" ", &softtabstop)/g
    catch E486
        echomsg "No tabs to expand."
    endtry
    call setpos('.', cursor)
    call setreg('/', query)
endfunction

" Inserts a Markdown/RST header line on the current line based on the line above
" with some hacky substitution magic.
function! HeaderLine(char)
    let query = getreg('/')
    let l:x=line(".")
    if l:x > 1
        let l:length=strlen(getline(l:x - 1))
        .s/^.*$/\=repeat(a:char, l:length)/g
    else
        echomsg "Can't insert a line here."
    endif
    call setreg('/', query)
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
        %s/\n\n\n\n/\r/ge
        %s/^#.*$//ge
        %s/);/) {\r   \/* TODO *\/\r}/ge
        normal ggO
        exec "normal i#include \"".l:headerfile."\""

    elseif filereadable(glob("~/.vim/templates/template.c"))
        " Make it from template
        read ~/.vim/templates/template.c
        normal ggdd7G
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

" Show us when lines go over 100 characters in length.
function! ShowLongLines()
    let cursor = getpos(".")
    let query = getreg('/')
    try
        match ErrorMsg "\%>100v.\+"
    catch E486
        echomsg "All lines are within 100 characters."
    endtry
    call setpos('.', cursor)
    call setreg('/', query)
endfunction

" Comment or uncomment code depending on filetype
function! Comment()
    if &filetype=="c" || &filetype=="cpp" || &filetype=="javascript"
        let l:char="//"
    elseif &filetype=="python" || &filetype=="conf" || &filetype=="sh"
        let l:char="#"
    elseif &filetype=="vim"
        let l:char="\""
    endif

    " If the current line starts with the comment character, strip the comments;
    " otherwise, comment out each line.
    let l:line=getline(".")
    let l:charLen = strlen(l:char)
    if strpart(l:line, 0, l:charLen) ==# l:char
        exec "normal 0".l:charLen."x"
    else
        exec "normal 0i".l:char
    endif
endfunction

" Deletes all trailing whitespace.
function! DeleteTrailingWhitespace()
    let cursor = getpos(".")
    let query = getreg('/')
    %substitute/\s\+$//ge
    call setpos('.', cursor)
    call setreg('/', query)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom keybindings and mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets the value of <LEADER> (default is the backslash)
let mapleader=" "

" Convenience key bindings for selecting and yanking lines.
map Y y$
nmap <LEADER>a ggVG
vmap <LEADER>y :w !pbcopy<CR><CR>


" Familiar keybindings for controlling history.
nmap <C-z> :undo<CR>
nmap <C-y> :redo<CR>

" Automatically complete braces and parentheses.
inoremap {<CR>  {<CR>}<ESC>ko
inoremap [<CR>  [<CR>]<ESC>ko
inoremap (<CR>  (<CR>)<ESC>ko

" Jump quickly between tabs.
nnoremap <TAB> :tabnext<CR>
nnoremap <S-TAB> :tabprevious<CR>

" Shortcut for reloading vimrc.
nmap <LEADER>r :source ~/.vimrc<CR>

" Clear search and match highlighting.
nmap <LEADER><LEADER> :match none<CR>:nohlsearch<CR>

" Find annoying things in code.
nmap <LEADER>l :call ShowLongLines()<CR>
nmap <LEADER>w :call DeleteTrailingWhitespace()<CR>

" Manipulating lines.
nmap <LEADER>- :call HeaderLine("-")<CR>
nmap <LEADER>= :call HeaderLine("=")<CR>
nmap <LEADER><CR> o<ESC>
vmap > >gv
vmap < <gv

" Format the current file.
nmap <LEADER>f :call ClangFormat()<CR>

" Automatic block commenting and uncommenting
vmap <LEADER>/ :call Comment()<CR>

" See what's changed in the current buffer
nmap <LEADER>ds :call DiffSaved()<CR>
nmap <LEADER>dg :call DiffGit()<CR>

" Jump around in code via YouCompleteMe
nmap <LEADER>gj :YcmCompleter GoTo<CR>
nmap <LEADER>gp :YcmCompleter GoToDeclaration<CR>
nmap <LEADER>gd :YcmCompleter GoToDefinition<CR>
nmap <LEADER>gf :YcmCompleter GoToImprecise<CR>

" Open TagBar
nmap <LEADER>n :TagbarOpenAutoClose<CR>

" CommandT
nmap <LEADER>t :CommandT<CR>
nmap <LEADER>b :CommandTBuffer<CR>
nmap <LEADER>j :CommandTJump<CR>
nmap <LEADER>s :CommandTTag<CR>
nmap <LEADER>/ :CommandTLine<CR>
nmap <LEADER>? :CommandTHelp<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors
set background=light
colorscheme solarized           " Solarized
let g:solarized_termtrans=1     " Use a completely-transparent background

" YouCompleteMe
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_error_symbol='✘✘'
let g:ycm_extra_conf_globlist=['~/code/*', '~/code/mongo/*']
let g:ycm_key_detailed_diagnostics=''
let g:ycm_key_invoke_completion='<C-N>'
let g:ycm_key_list_previous_completion=['<S-TAB>', '<Up>', '<C-P>']
let g:ycm_key_list_select_completion=['<TAB>', '<Down>', '<C-N>']
let g:ycm_use_ultisnips_completer = 0
let g:ycm_warning_symbol='!!'

" TagBar
let g:tagbar_autoclose = 1
let g:tagbar_case_insensitive = 1
let g:tagbar_left = 1
let g:tagbar_map_close = "<C-C>"
let g:tagbar_width = 60

" CommandT
let g:CommandTFileScanner = "git"
let g:CommandTIgnoreCase = 1
let g:CommandTIgnoreSpaces = 1

" Wild menu settings
set wildignore=*.o,*.jpg,*.png,*.gif,*.pyc,*.tar,*.gz,*.zip,*.class,*.pdf
set wildmenu
set wildmode=longest:full,full

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
set incsearch
set laststatus=2                " Always show the status bar
set modelines=5                 " Modelines for OSX
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
set textwidth=100               " Stay within 100 characters
set timeout                     " Time out on both mappings and keycodes
set timeoutlen=300              " 300ms time-out length
syntax enable                   " Syntax highlighting

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Check for outside updates, reloading the buffer if `autoread` is set.
autocmd BufEnter,FocusGained * checktime %

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
    autocmd BufRead,BufNewFile README,Readme set filetype=ghmarkdown
    autocmd BufRead,BufNewFile SConscript set filetype=python
augroup end

" Change indentation and text settings based on filetype
augroup filetype_indentation
    autocmd FileType c set shiftwidth=4 tabstop=4
    autocmd FileType go set textwidth=0
    autocmd FileType html set shiftwidth=2 tabstop=2 textwidth=0
    autocmd FileType python set textwidth=80
    autocmd FileType xml setl shiftwidth=2 tabstop=2 textwidth=0
augroup end

" Create these files from templates.
let s:template="~/.vim/templates/template."
if glob("~/.vim/templates/") != ""
    " Load a basic template based off of the file extension
    augroup templates_simple
        autocmd!
        autocmd BufNewFile *.cpp,*.html,*.js,*.php,*.py,*.page,*.sh,*.spec,*.tex
                    \ silent! exe "0r ".s:template.fnamemodify(@%, ":e")
    augroup end

    " Does more than just render the template, like calling a function
    augroup templates_plus
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
