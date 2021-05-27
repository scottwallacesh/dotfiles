set nocompatible              " be iMproved, required
filetype off                  " required

" Disable bell
set vb

" Enable modeline in files
set modeline

" Ensure vim knows about Go(lang)
set rtp+=$GOROOT/misc/vim

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'cocopon/lightline-hybrid.vim'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'rodjek/vim-puppet'
Plugin 'godlygeek/tabular'
Plugin 'ap/vim-buftabline'
Plugin 'vim-scripts/WhiteWash'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'davidhalter/jedi'
Plugin 'plasticboy/vim-markdown'

" All of your Plugins must be added before the following line
call vundle#end()            " required
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

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" Autocomplete
let g:neocomplcache_enable_at_startup = 1

" Disable Markdown folding
let g:vim_markdown_folding_disabled = 1

" Set filetypes
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.go set filetype=go

" Lightline
set laststatus=2
let g:lightline = {
    \   'colorscheme': 'hybrid',
    \   'active': {
    \     'left': [ [ 'mode', 'paste' ],
    \               [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
    \   },
    \   'component_function': {
    \     'fugitive': 'LightLineFugitive',
    \     'readonly': 'LightLineReadonly',
    \     'modified': 'LightLineModified',
    \     'filename': 'LightLineFilename'
    \   },
    \   'mode_map': {
    \     'n' : 'N',
    \     'i' : 'I',
    \     'R' : 'R',
    \     'v' : 'V',
    \     'V' : 'V-L',
    \     "\<C-v>": 'V-B',
    \     'c' : 'C',
    \     's' : 'S',
    \     'S' : 'S-L',
    \     "\<C-s>": 'S-B',
    \     '?': '      '
    \   },
    \   'separator': { 'left': '', 'right': '' },
    \   'subseparator': { 'left': '>', 'right': '<' }
    \ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "!"
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? 'git:'._ : ''
  endif
  return ''
endfunction
