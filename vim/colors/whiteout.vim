" ----------------------------------------------------------------------------
" whiteout.vim - An extremely minimalistic color scheme.
"
" Sometimes colors get in the way, so this color scheme stays simple. It's
" all white, with a splash of color where it's important.
" ----------------------------------------------------------------------------

let colors_name = "whiteout"

" Use a dark background
set background=dark

" Clear the existing highlighting
highlight clear
if exists("syntax_on")
    syntax reset
endif

" ----------------------------------------------------------------------------
" Syntax Highlighting
" Reset all of the colors, so we can default to white nothingness
" ----------------------------------------------------------------------------
" Important  groups for syntax 'coloring'
highlight Comment NONE ctermfg=DarkGrey
highlight Constant NONE term=underline ctermfg=Grey cterm=bold
highlight Identifier NONE cterm=underline
highlight PreProc NONE ctermfg=LightGrey
highlight LineNr NONE term=underline ctermfg=DarkGrey
highlight Special NONE ctermfg=White cterm=bold
highlight SpecialKey NONE term=bold ctermfg=White
highlight Statement NONE term=bold cterm=bold ctermfg=White
highlight Type NONE term=bold cterm=bold ctermfg=White

" The status line and window borders
highlight StatusLine term=reverse,bold ctermfg=Black ctermbg=White
highlight StatusLineNC term=reverse cterm=reverse ctermfg=Black ctermbg=White
highlight VertSplit term=reverse ctermbg=White ctermfg=black

" Things that show up near the status line
highlight Directory NONE term=bold ctermfg=White
highlight ModeMsg NONE term=bold cterm=bold
highlight MoreMsg NONE term=bold cterm=bold
highlight Title NONE term=bold cterm=bold
highlight WildMenu NONE term=standout ctermbg=Black ctermfg=White

" Cursor, line, and columns
highlight ColorColumn NONE ctermbg=DarkGrey
highlight CursorColumn NONE cterm=none ctermfg=Black ctermbg=LightGrey
highlight CursorLine NONE

" Errors, warnings, and stand-out text
highlight ErrorMsg NONE term=standout ctermbg=Red ctermfg=White
highlight Todo NONE term=standout ctermfg=Red
highlight WarningMsg NONE term=standout cterm=bold ctermfg=Red

" Diff-mode settings
highlight DiffAdd NONE term=bold ctermfg=Green
highlight DiffChange NONE term=bold ctermfg=Blue
highlight DiffDelete NONE term=bold ctermfg=Red
highlight DiffText NONE term=reverse ctermfg=Blue

" Other highlight groups
highlight FoldColumn NONE term=standout ctermbg=LightGrey ctermfg=Black
highlight Folded NONE term=standout ctermbg=LightGrey ctermfg=Black
highlight Ignore NONE ctermfg=DarkGrey
highlight IncSearch NONE term=reverse cterm=reverse
highlight NonText NONE term=bold cterm=bold
highlight Normal ctermfg=Gray
highlight Question term=standout ctermbg=DarkGrey ctermfg=White
highlight Search NONE term=reverse cterm=reverse
highlight Visual NONE term=reverse ctermbg=White ctermfg=Black
highlight VisualNOS term=underline,bold cterm=underline,bold
