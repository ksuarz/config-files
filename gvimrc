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

" GVim-specific settings
set background=light
colorscheme solarized
nmap <C-r> :source ~/.gvimrc<CR>
