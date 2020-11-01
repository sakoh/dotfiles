set nocompatible
filetype plugin on
syntax on
set number

source $HOME/.config/nvim/plugin-config/airline.vim

call plug#begin('~/.local/share/nvim/plugged')

Plug 'davidhalter/jedi-vim'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdcommenter'

Plug 'cocopon/pgmnt.vim'

Plug 'cocopon/iceberg.vim'

Plug 'arcticicestudio/nord-vim'

"QML highlighting"
Plug 'crucerucalin/qml.vim'

"NerTree"
Plug 'preservim/nerdtree'

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'vimwiki/vimwiki'

Plug 'tools-life/taskwiki'

Plug 'tpope/vim-fugitive'

Plug 'ryanoasis/vim-devicons'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

let g:deoplete#enable_at_startup = 1

colorscheme nord

nnoremap <silent> <C-T> :NERDTreeToggle<CR>

let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

autocmd BufWritePre * %s/\s\+$//e
