""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File:           numbers.vim
" Maintainer:     amadanmath@gmail.com
"                 based on Mahdi Yusuf yusuf.mahdi@gmail.com
" Version:        0.1.0
" Description:    vim global plugin for better line numbers.
" Last Change:    26 June, 2012
" License:        MIT License
" Location:       plugin/numbers.vim
" Website:        https://github.com/myusuf3/numbers.vim
"
" See numbers.txt for help.  This can be accessed by doing:
"
" :helptags ~/.vim/doc
" :help numbers
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let s:numbers_version = '0.3.0'

"Allow use of line continuation
let s:save_cpo = &cpo
set cpo&vim

if exists("g:loaded_numbers") && g:loaded_numbers
    finish
endif
let g:loaded_numbers = 1

if v:version < 703 || &cp
    echomsg "numbers.vim: you need at least Vim 7.3 and 'nocp' set"
    echomsg "Failed loading numbers.vim"
    finish
endif

function! NumbersEnable()
    let g:enable_numbers = 1
    augroup NumbersAug
        au!
        " autocmd InsertEnter * set number
        " autocmd InsertLeave * set relativenumber
        autocmd BufNewFile  * set number relativenumber
        autocmd BufReadPost * set number relativenumber
        autocmd WinEnter    * set number relativenumber
        autocmd WinLeave    * set nonumber norelativenumber
    augroup END
    set number relativenumber
endfunc

function! NumbersDisable()
    let g:enable_numbers = 0
    augroup NumbersAug
        au!
    augroup END
    set nonumber norelativenumber
endfunc

function! NumbersToggle()
    if g:enable_numbers == 1
        call NumbersDisable()
    else
        call NumbersEnable()
    endif
endfunction

function! UnsetNumbers()
endfunction

" Commands
command! -nargs=0 NumbersEnable call NumbersEnable()
command! -nargs=0 NumbersDisable call NumbersDisable()
command! -nargs=0 NumbersToggle call NumbersToggle()

" reset &cpo back to users setting
let &cpo = s:save_cpo

call NumbersEnable()
