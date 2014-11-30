set nocompatible              " be iMproved, required
filetype off                  " required

" Ensure vim knows about Go(lang)
set rtp+=$GOROOT/misc/vim

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin '29decibel/codeschool-vim-theme'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'godlygeek/tabular'
Plugin 'ap/vim-buftabline'
Plugin 'vim-scripts/WhiteWash'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

colorscheme codeschool

" Airline
set laststatus=2

" Tabs and indents
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" Allow mouse usage
set mouse=a

" Always use vertical diffs
set diffopt+=vertical

" Syntax highlighting
syntax on

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Autocomplete
let g:neocomplcache_enable_at_startup = 1

" Set filetypes
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.go set filetype=go
