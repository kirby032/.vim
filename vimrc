"Turn line numbers on
"
set number
"Turn current cursor position in bottom corner on
set ruler
"Turn incremental search on (searches while typing)
set incsearch
"Highlight search word
set hlsearch
"Search case-insensitive by default
set ignorecase
set smartcase
"Set color scheme to monokai
colorscheme monokai
"Syntax highlighting
syntax on
"Set vim to use 256 color
set t_Co=256
"set tags file to .tags
set tags=.tags
"show whitespaces
set listchars=tab:>-,trail:.
set list
match ErrorMsg '\s\+$'
"Set 4 spaces to a TAB
set tabstop=4
set shiftwidth=4
set expandtab
nnoremap <leader>t <Esc>:set expandtab!<cr>
"Use mouse controls
set mouse=a
"Set column width marker
set colorcolumn=81
"Enable a vim title
set title
"Dont be compatible with vi
set nocompatible
"Sett buffers to be able to be hidden (don't have to save when switching)
set hidden
"Set leader key
let mapleader = ','
"Show status line"
set laststatus=2
"Set bashlike file completion
set wildmode=longest,list,full
set wildmenu
"Set backspace to always allow
set backspace=eol,start,indent

"Default to searching for highlighted word
vnoremap / y<esc>/<C-R>"
"Allow search to wrap bottom of the file
set wrapscan


"
" Key-mappings
"

" If the current buffer has never been saved, it will have no name,
" " call the file browser to save it, otherwise just save it.
if !exists(":UpdateSaveFile")
    command -nargs=0 -bar UpdateSaveFile if &modified
                               \|    if empty(bufname('%'))
                               \|        browse confirm write
                               \|    else
                               \|        confirm write
                               \|    endif
                               \|endif
endif

nnoremap <silent> <C-S> :<C-u>UpdateSaveFile<CR>
inoremap <silent> <C-S> <ESC>:<C-u>UpdateSaveFile<CR>

"Make j/k/h/l behave sanely!
"noremap j jzz
"noremap k kzz
"noremap h hzz
"noremap l lzz

"Move single line up or down
noremap - ddp
noremap _ ddkkp

"shortcut to uppercase word
inoremap <c-u> <esc>viwwhUeli
nnoremap <c-u> viwwhUel

"Open up vimrc for modification
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"Change enter to insert newline
nnoremap <S-Enter> O<Esc>
nnoremap <CR> o<Esc>

"H-L goto beginning/end of line
nnoremap <S-h> 0
nnoremap <S-l> $
vnoremap <S-h> 0
vnoremap <S-l> $

"Surround visually selected in quotes
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>

"Add new excap mapping from insert mode
inoremap jk <esc>


"Comment shortcut for C
nnoremap <leader>/ I//<esc>
inoremap <leader>/ <esc>I//<esc>
vnoremap <leader>/ <esc>`<i/*<esc>`>la*/<esc>

"Paste-toggle"
nnoremap <leader>p :set paste!<cr>

"toggle buffer"
nnoremap <leader>n :bnext<cr>
nnoremap <leader><S-P> :bprevious<cr>
nnoremap gn :bnext<cr>
nnoremap gp :bprevious<cr>

"Add copy/paste from clipboard
nnoremap <leader>p "+p

vnoremap <leader>p d"+p
vnoremap <leader>c "+y

"Add buffer movements
nnoremap gn :bnext<cr>
nnoremap gp :bprevious<cr>

"Autogroups

augroup c_file_types
    autocmd!
    autocmd FileType C set nospell
augroup END

augroup txt_file_types
    autocmd!
    autocmd FileType text set spell spelllang=en_us
augroup END


"
" Pathogen (plugin manager) settings
"
filetype plugin indent on
call pathogen#infect()

"
"Ctrl-P plugin settings
"
let g:ctrlp_max_files = 0
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_extensions = ['tag']
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
noremap <silent> <C-z> :CtrlPTag<cr>

"
"YCM disable compilation
"
let g:ycm_largfile=1

"
"Silver-searcher (Ag) plugin settings
"
let g:ag_working_path_mode="r"
nnoremap <leader>f <Esc>:", "<C-R>P")<C-B>call Project_search("<C-R>Q
vnoremap <leader>f y<Esc>:")<C-B>call Project_search("<C-R>"", "<C-R>P

"
"vim-airline (tab and buffer viewer) settings
"
let g:airline_theme = 'dark'
let g:airline#extensions#tabline#fnamemod = ":t"
let g:airline_section_c = '%<%Fm %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
let g:airline#extensions#tabline#enabled = 1

"
"vim-minimap settings
"
let g:minimap_highlight='Visual'

"
"bClose script settings
"
let bclose_multiple = 0


"
" FUNCTIONS
"

function! Project_search(pattern, path)
    echom "path: " a:path " pattern: " a:pattern
    let @p = a:path
    let @q = a:pattern
    call ag#Ag('grep','-S ' . a:pattern . ' ' . a:path)
endfunction


