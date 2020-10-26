set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

call plug#begin('~/.local/share/nvim/plugged')

Plug 'davidhalter/jedi-vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdcommenter'

Plug 'cocopon/pgmnt.vim'

Plug 'cocopon/iceberg.vim'

Plug 'arcticicestudio/nord-vim'

call plug#end()

let g:deoplete#enable_at_startup = 1

let g:airline_theme='nord'

colorscheme nord

