" Better indenting
vnoremap < <gv
vnoremap > >gv

" no need to use Esc
inoremap jk <Esc>
inoremap kj <Esc>
nnoremap <C-c> <Esc>

" Alternative way to save
nnoremap <C-s> :w<CR>

" Alternate way to quit
nnoremap <C-q> :wq!<CR>

" Use alt + hjkl to resize windows
nnoremap <M-j> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-l> :vertical resize +2<CR>
