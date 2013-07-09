" See if a file exists
function! HasFile(file)
    if filereadable(a:file)
        echo "Found file."
    else
        echo "No file found."
    endif
endfunction


" Toggles curly brace autocompletion.
function! AutocompleteBraces(...)
    let s:x = 0
    if a:0 > 1
        echo "Use no arguments to toggle, or one to specify."
        return
    else
        s:x = a:0 == 0 ? 1 : a:1
    endif

    if !maparg("") && s:x
        " Completion for curly braces
        inoremap {  {}<LEFT>
        inoremap {{ {
        inoremap {<CR>  {<CR>}<ESC>ko
        inoremap {} {}
        echo "Brace completion turned on."
    else
        iunmap {
        iunmap {{
        iunmap {<CR>
        iunmap {}
        echo "Brace completion turned off."
endfunction
