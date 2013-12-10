" .vimrc configuration

set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" Custom bundles
Bundle 'altercation/vim-colors-solarized.git'


filetype plugin indent on

" Source initialization files
runtime! init/**.vim
