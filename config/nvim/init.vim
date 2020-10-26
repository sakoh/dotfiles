syntax on
set number

call plug#begin('~/.local/share/nvim/plugged')

Plug 'davidhalter/jedi-vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

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

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'vimwiki/vimwiki'

Plug 'tools-life/taskwiki'

Plug 'tpope/vim-fugitive'

Plug 'ryanoasis/vim-devicons'

call plug#end()

let g:deoplete#enable_at_startup = 1

let g:airline_theme='nord'

colorscheme nord

nnoremap <silent> <C-k><C-B> :NERDTreeToggle<CR>
