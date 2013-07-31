""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .gvimrc - Vim configuration settings
" See .vimrc for most settings, mappings, and function definitions.
" Kyle Suarez
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" Use common vim settings.
if filereadable(glob('~/.vimrc'))
    source ~/.vimrc
endif

" GVim-specific color scheme settings
colorscheme solarized
set background=light

" We need to point our reload mapping to gvimrc
nnoremap <LEADER>r :source ~/.gvimrc<CR>
