" ----------------------------------------------------------------------------
" simple.vim - A simple color scheme for 256-color terminals.
" ----------------------------------------------------------------------------

let colors_name="simple"

" Use a dark background
set background=dark

" Clear the existing highlighting
highlight clear
if exists("syntax_on")
    syntax reset
endif

" ----------------------------------------------------------------------------
" Syntax Highlighting
" ----------------------------------------------------------------------------
" The important syntax coloring groups - the ones you really care about
highlight Constant term=underline ctermfg=Magenta
highlight Identifier term=bold ctermfg=Blue
highlight LineNr term=underline cterm=none ctermfg=DarkGrey
highlight Normal ctermfg=White
highlight PreProc term=underline ctermfg=Cyan
highlight Special term=bold ctermfg=Red
highlight SpecialKey term=bold ctermfg=Blue
highlight Statement term=bold cterm=bold ctermfg=Yellow
highlight Type term=bold ctermfg=Green

" The status line, window borders, and the like
highlight StatusLine cterm=bold ctermfg=White ctermbg=Black
highlight StatusLineNC ctermfg=Black ctermbg=White
highlight VertSplit ctermfg=Black ctermbg=White

" Things that show up in or near the status line
highlight Directory term=bold ctermfg=Cyan
highlight ModeMsg term=bold cterm=bold
highlight MoreMsg term=bold ctermfg=Green
highlight Title term=bold ctermfg=Green
highlight WildMenu term=standout ctermfg=White ctermbg=DarkCyan

" The cursor, line, and columns
highlight ColorColumn ctermbg=Black cterm=bold
highlight Cursor cterm=none ctermbg=White ctermfg=Black
highlight CursorColumn term=reverse ctermbg=Black
highlight CursorLine cterm=bold ctermbg=Black term=underline
highlight CursorLineNr cterm=bold ctermfg=White

" Diff-mode settings
highlight DiffAdd term=bold ctermbg=DarkBlue
highlight DiffChange term=bold ctermbg=Magenta
highlight DiffDelete term=bold ctermfg=Blue ctermbg=Cyan
highlight DiffText term=reverse cterm=bold ctermbg=Red

" Errors, warnings, and stand-out text
highlight ErrorMsg term=standout ctermbg=Red ctermfg=White
highlight Todo term=standout ctermfg=Red
highlight WarningMsg term=standout ctermfg=Red

" Other highlight groups
highlight FoldColumn term=standout ctermbg=LightGrey ctermfg=DarkBlue
highlight Folded term=standout ctermbg=LightGrey ctermfg=DarkBlue
highlight Ignore ctermfg=DarkGrey
highlight IncSearch term=reverse cterm=reverse
highlight NonText term=bold ctermfg=LightBlue
highlight Question term=standout ctermfg=Green
highlight Search term=reverse ctermbg=White ctermfg=Black
highlight Visual term=reverse cterm=bold ctermbg=DarkBlue
highlight VisualNOS term=underline,bold cterm=underline,bold
