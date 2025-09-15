" Normally, the { and } motions only match completely empty lines.
" With this plugin, lines that only contain whitespace are also matched.
" URL: https://github.com/dbakker/vim-paragraph-motion
" License: BSD Zero Clause License (0BSD)

if exists('g:loaded_paragraphmotion') || &cp
    finish
endif
let g:loaded_paragraphmotion = 1

if !exists('g:paragraphmotion_keepjumps')
    let g:paragraphmotion_keepjumps = 0
endif

if !exists('g:paragraphmotion_skipfolds')
    let g:paragraphmotion_skipfolds = 0
endif

let s:save_cpo = &cpo
set cpo&vim

function! s:ParagraphMove(delta, visual, count)
    if !g:paragraphmotion_keepjumps
        normal! m'
    endif
    if a:visual
        normal! gv
    endif

    normal! ^
    let flags = a:delta < 0 ? 'bW' : 'W'
    let i = 0
    while i < a:count
        " First empty or whitespace-only line below a line that contains
        " non-whitespace characters.
        if search('\m[^[:space:]]', flags . 'c') == 0 || search('\m^[[:space:]]*$', flags) == 0
            if a:delta < 0
                call cursor(1, 1)
            else
                call search('\m\%$', 'W')
            endif
            return
        endif
        if g:paragraphmotion_skipfolds && foldclosed('.') > 0
            continue
        endif
        let i += 1
    endwhile
endfunction

nnoremap <unique> <silent> } :<C-U>call <SID>ParagraphMove( 1, 0, v:count1)<CR>
onoremap <unique> <silent> } :<C-U>call <SID>ParagraphMove( 1, 0, v:count1)<CR>
xnoremap <unique> <silent> } :<C-U>call <SID>ParagraphMove( 1, 1, v:count1)<CR>
nnoremap <unique> <silent> { :<C-U>call <SID>ParagraphMove(-1, 0, v:count1)<CR>
onoremap <unique> <silent> { :<C-U>call <SID>ParagraphMove(-1, 0, v:count1)<CR>
xnoremap <unique> <silent> { :<C-U>call <SID>ParagraphMove(-1, 1, v:count1)<CR>

let &cpo = s:save_cpo
unlet s:save_cpo
