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

let s:numbers_version = '0.2.0'

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
        autocmd InsertEnter * set number
        autocmd InsertLeave * set relativenumber
        autocmd BufNewFile  * set number
        autocmd BufReadPost * set number
        autocmd WinLeave    * call UnsetNumbers()
        autocmd WinEnter    * set number
    augroup END
    set number
endfunc

function! NumbersDisable()
    let g:enable_numbers = 0
    augroup NumbersAug
        au!
    augroup END
    call UnsetNumbers()
endfunc

function! UnsetNumbers()
    set nonumber
    set norelativenumber
endfunction

" Commands
command! -nargs=0 NumbersEnable call NumbersEnable()
command! -nargs=0 NumbersDisable call NumbersDisable()

" reset &cpo back to users setting
let &cpo = s:save_cpo

call NumbersEnable()
