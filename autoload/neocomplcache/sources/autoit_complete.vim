let s:save_cpo = &cpo
set cpo&vim

let s:source = {
\    'name': 'autoit_complete',
\    'kind': 'ftplugin',
\    'filetypes': { 'autoit': 1 },
\ }

function! s:source.initialize()
endfunction

function! s:source.finalize()
endfunction

function! s:source.get_keyword_pos(cur_text)
    return match(a:cur_text, '[#@]\?[0-9A-Za-z_-]*$')
endfunction

function! s:source.get_complete_words(cur_keyword_pos, cur_keyword_str)
    let keywords = []
    let fname = $AUTOITHOME . '/SciTE/api/au3.api'
    if filereadable(fname)
        for word in readfile(fname)
            call add(keywords, {
            \ 'word': matchstr(word, '^[0-9A-Za-z#@_-]\+'),
            \ 'menu': '[AutoIt]',
            \})
        endfor
    endif
    return neocomplcache#keyword_filter(keywords, a:cur_keyword_str)
endfunction

function! neocomplcache#sources#autoit_complete#define()
    return s:source
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
