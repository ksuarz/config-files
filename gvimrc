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
" Changes the background depending on if it's day or night.
function! AdjustBackground()
    let l:hour=strftime('%H')
    if l:hour > 7 && l:hour < 18
        let &background='light'
    else
        let &background='dark'
    endif
endfunction

" Gives a random color scheme based on the time and the background.
function! RandomColorScheme()
    if glob('~/.vim/colors') != ''
        let l:colors=(&background == 'dark' ? 
                    \['busybee', 'molokai', 'moria', 'solarized', 'hemisu'] :
                    \['github', 'oceanlight', 'pyte', 'solarized', 'tomorrow'])
        let l:filename=l:colors[strftime('%M') % len(l:colors)]
        highlight clear
        syntax reset
        silent! exec 'source ~/.vim/colors/'.l:filename.'.vim'
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GVim-specific color scheme settings
silent call AdjustBackground()
silent call RandomColorScheme()

" We need to point our reload mapping to gvimrc
nnoremap <LEADER>r :source ~/.gvimrc<CR>
