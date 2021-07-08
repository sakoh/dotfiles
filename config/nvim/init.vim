set nocompatible
filetype plugin on
syntax on
set number

let g:deoplete#enable_at_startup = 1

colorscheme nord

let g:vim_tree_auto_open = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_follow = 1

nnoremap <C-t> :NvimTreeToggle <CR>
nnoremap <leader>r :NvimTreeRefresh <CR>
nnoremap <leader>t :NvimTreeFindFile <CR>

nnoremap <silent> <C-Z> :tabnext <CR>
nnoremap <silent> <C-X> :tabprevious <CR>

set encoding=utf8

lua require('init')
