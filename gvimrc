""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .gvimrc - GUI Vim configuration settings
" See .vimrc for most settings, mappings, and function definitions.
" Kyle Suarez
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" Use common vim settings.
if filereadable(glob('~/.vimrc'))
    source ~/.vimrc
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Function Definitions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Changes the background depending on the current time.
function! AdjustBkgByTime()
    let l:hour=strftime('%H')
    if l:hour > 7 && l:hour < 18
        let &background='light'
    else
        let &background='dark'
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GVim-specific color scheme settings
colorscheme solarized
call AdjustBkgByTime()

" We need to point our reload mapping to gvimrc
nnoremap <LEADER>r :source ~/.gvimrc<CR>
