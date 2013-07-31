" whiteout.vim
"
" Sometimes colors get in the way, so this color scheme stays simple. It's
" all white, with a splash of color where it's important.

" First, clear previous colors.
highlight clear
if exists("syntax_on")
  syntax reset
endif

" Use a dark background.
set background=dark
let colors_name = "whiteout"

" Reset all of the colors, so we can default to white nothingness
highlight ColorColumn NONE ctermbg=DarkGrey
highlight CursorColumn NONE cterm=none ctermfg=Black ctermbg=LightGrey
highlight CursorLine term=underline cterm=none ctermfg=Black ctermbg=LightGrey
highlight DiffAdd NONE term=bold ctermfg=Green
highlight DiffChange NONE term=bold ctermfg=Blue
highlight DiffDelete NONE term=bold ctermfg=Red
highlight DiffText NONE term=reverse ctermfg=Blue
highlight Directory NONE term=bold ctermfg=White
highlight ErrorMsg NONE term=standout ctermbg=DarkRed ctermfg=White
highlight FoldColumn NONE term=standout ctermbg=LightGrey ctermfg=Black
highlight Folded NONE term=standout ctermbg=LightGrey ctermfg=Black
highlight Ignore NONE ctermfg=DarkGrey
highlight IncSearch NONE term=reverse cterm=reverse
highlight LineNr NONE term=underline ctermfg=DarkGrey
highlight ModeMsg NONE term=bold cterm=bold
highlight MoreMsg NONE term=bold cterm=bold
highlight NonText NONE term=bold cterm=bold
highlight Normal ctermfg=Gray
highlight Question term=standout ctermbg=DarkGrey ctermfg=White
highlight Search NONE term=reverse cterm=reverse
highlight StatusLine NONE term=reverse,bold cterm=reverse,bold
highlight StatusLineNC NONE term=reverse cterm=reverse
highlight Title NONE term=bold cterm=bold
highlight Todo NONE ctermfg=Cyan
highlight VertSplit term=reverse cterm=reverse
highlight Visual NONE term=reverse ctermbg=White ctermfg=Black
highlight VisualNOS term=underline,bold cterm=underline,bold
highlight WarningMsg NONE term=standout cterm=bold ctermfg=Cyan
highlight WildMenu NONE term=standout ctermbg=Black ctermfg=White

" Special groups for syntax 'coloring'
highlight Comment NONE ctermfg=DarkGrey
highlight Constant NONE term=underline ctermfg=Grey cterm=bold
highlight Identifier NONE cterm=underline
highlight PreProc NONE ctermfg=LightGrey
highlight Special NONE ctermfg=White cterm=bold
highlight SpecialKey NONE term=bold ctermfg=White
highlight Statement NONE term=bold cterm=bold ctermfg=White
highlight Type NONE term=bold cterm=bold ctermfg=White
