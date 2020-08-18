syntax on
set number
autocmd BufWritePre *.py :%s/\s\+$//e
