set nocompatible              " be iMproved, required
filetype off                  " required

" Disable bell
set vb

" Enable modeline in files
set modeline

filetype plugin indent on    " required

" Hybrid color scheme
let g:hybrid_use_Xresources = 1
set background=dark
" colorscheme hybrid

" Tabs and indents
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Always use vertical diffs
set diffopt+=vertical

" Syntax highlighting
syntax on
