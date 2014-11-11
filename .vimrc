set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin '29decibel/codeschool-vim-theme'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

colorscheme codeschool

" Airline
set laststatus=2

set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" Allow mouse usage
set mouse=a

" Always use vertical diffs
set diffopt+=vertical

syntax on
