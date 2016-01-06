"Turn line numbers on
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
"show whitspaces
set listchars=tab:>—,trail:·
set list
"Set 4 spaces to a TAB
set tabstop=4
set shiftwidth=4
set expandtab
map <leader>t <Esc>:set expandtab!<cr>
"Use mouse controls
set mouse=a
"Set column width marker
set colorcolumn=81
"Enable a vim title
set title
"Dont be compatible with vi
set nocompatible

"
" Key-mappings
"

" If the current buffer has never been saved, it will have no name,
" " call the file browser to save it, otherwise just save it.
command -nargs=0 -bar Update if &modified 
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
noremap <silent> <C-S> :<C-u>Update<CR>
noremap! <silent> <C-S> <ESC>:<C-u>Update<CR>

"Make j/k/h/l behave sanely!
map j jzz
map k kzz
map h hzz
map l lzz

"Move single line up or down
map - ddp
map _ ddkkp

"shortcut to uppercase word
imap <c-u> <esc>bveUi

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
"Silver-searcher (Ag) plugin settings
"
let g:ag_working_path_mode="r"
map <leader>f <Esc>:Ag -S 

"
"vim-airline (tab and buffer viewer) settings
"
let g:airline#extensions#tabline#enabled = 1

"
"vim-minimap settings
"
let g:minimap_highlight='Visual'

"
"bClose script settings
"
let bclose_multiple = 0



