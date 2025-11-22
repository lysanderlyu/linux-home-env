syntax enable
set nowrap
set number
set relativenumber
set hlsearch
set ignorecase
let mapleader = "\<Space>"
autocmd BufRead,BufNewFile *.S set filetype=c
autocmd FileType c,cpp setlocal smartindent autoindent 

nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fc :Rgc<CR>
nnoremap <leader>fj :Rgj<CR>
nnoremap <leader>ff :Files<CR>


nnoremap <leader>;w :w<CR>
nnoremap <leader>;W :wq<CR>
nnoremap <leader>;q :q<CR>
nnoremap <leader>;Q :q!<CR>
nnoremap <leader>;' :"+y<CR>
nnoremap <leader>'; :"+p<CR>

command! Rg call fzf#vim#grep('rg --no-ignore --column --line-number --no-heading --color=always --smart-case -- ' . shellescape(@"), fzf#vim#with_preview(), 0)
command! Rgc call fzf#vim#grep('rg --glob=*.c --glob=*.h --glob=*.cpp --glob=*.cc --glob=*.cxx --glob=*.hpp --glob=*.hxx --no-ignore --column --line-number --no-heading --color=always --smart-case -- ' . shellescape(@"), fzf#vim#with_preview(), 0)
command! Rgj call fzf#vim#grep('rg --glob=*.java --no-ignore --column --line-number --no-heading --color=always --smart-case -- ' . shellescape(@"), fzf#vim#with_preview(), 0)
