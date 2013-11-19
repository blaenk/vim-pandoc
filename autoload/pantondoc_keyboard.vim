" vim: set fdm=marker:

function! pantondoc_keyboard#InitKeyboard()
    noremap <buffer> <silent> <localleader>i :set opfunc=pantondoc_keyboard#EMPH<CR>g@
    vnoremap <buffer> <silent> <localleader>i :<C-U>call pantondoc_keyboard#EMPH(visualmode())<CR>
    noremap <buffer> <silent> <localleader>b :set opfunc=pantondoc_keyboard#BOLD<CR>g@
    vnoremap <buffer> <silent> <localleader>b :<C-U>call pantondoc_keyboard#BOLD(visualmode())<CR>
    noremap <buffer> <silent> <localleader>rg :call pantondoc_keyboard#GOTO_Ref()<CR>
    noremap <buffer> <silent> <localleader>rb :call pantondoc_keyboard#BACKFROM_Ref()<CR>
endfunction

" Italicize: {{{1
function! pantondoc_keyboard#Emph(type)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@
    if a:type ==# "v"
	execute "normal! `<".a:type."`>x"
    elseif a:type ==# "char"
        execute "normal! `[v`]x"
    else
	return
    endif
    let @@ = '*'.@@.'*'
    execute "normal P"
    let @@ = reg_save
    let &selection = sel_save
endfunction

function! pantondoc_keyboard#EMPH(type)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@
    if a:type ==# "v"
	execute "normal! `<".a:type."`>x"
    elseif a:type ==# "char"
        execute "normal! `[ebv`]BEx"
    else
	return
    endif
    let @@ = '*'.@@.'*'
    execute "normal P"
    let @@ = reg_save
    let &selection = sel_save
endfunction
"}}}1
" Bold: {{{1
function! pantondoc_keyboard#Bold(type)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@
    if a:type ==# "v"
	execute "normal! `<".a:type."`>x"
    elseif a:type ==# "char"
        execute "normal! `[v`]x"
    else
	return
    endif
    let @@ = '**'.@@.'**'
    execute "normal P"
    let @@ = reg_save
    let &selection = sel_save
endfunction

function! pantondoc_keyboard#BOLD(type)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@
    if a:type ==# "v"
	execute "normal! `<b".a:type."`>ex"
    elseif a:type ==# "char"
        execute "normal! `[ebv`]BEx"
    else
	return
    endif
    let @@ = '**'.@@.'**'
    execute "normal P"
    let @@ = reg_save
    let &selection = sel_save
endfunction
" }}}1
" Navigation: {{{1

function! pantondoc_keyboard#GOTO_Ref()
    let reg_save = @@
    execute "mark ".g:pantondoc_mark
    execute "normal! ?[\<cr>vf]y"
    let @@ = substitute(@@, '\[', '\\\[', 'g')
    let @@ = substitute(@@, '\]', '\\\]', 'g')
    execute "normal! /".@@.":\<cr>"
    let @@ = reg_save
endfunction

function! pantondoc_keyboard#BACKFROM_Ref()
    execute "normal!  g'".g:pantondoc_mark
endfunction
" }}}1
