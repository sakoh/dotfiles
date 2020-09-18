syntax on
set number
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.sh :%s/\s\+$//e
