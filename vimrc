"Set leader key
let mapleader = ','
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
set tags=tags,.tags;/
"show whitespaces
set listchars=tab:>-,trail:.
set list
match ErrorMsg '\s\+$'
"Set 4 spaces to a TAB
set tabstop=4
set shiftwidth=4
set expandtab
set cino=(0,W4
nnoremap <leader>t <Esc>:set expandtab!<cr>
"Move up and down faster"
nnoremap <leader>j 50j
nnoremap <leader>k 50k
"Use mouse controls
set mouse=a
"Set column width marker
set colorcolumn=80
"Enable a vim title
set title
"Dont be compatible with vi
set nocompatible
"Sett buffers to be able to be hidden (don't have to save when switching)
set hidden
"Show status line"
set laststatus=2
"Set bashlike file completion
set wildmode=longest,list,full
set wildmenu
"Set backspace to always allow
set backspace=eol,start,indent

"Disable bracketed-paste mode since it breaks terminator
set t_BE=

"Default to searching for highlighted word
vnoremap / y<esc>/<C-R>"
"Allow search to wrap bottom of the file
set wrapscan

"For git and mercurial commits auto-wrap line at 72 chars"
au FileType gitcommit set tw=80
au FileType hgcommit set tw=80


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
vnoremap <leader>y "+ygvd

"Add buffer movements
nnoremap gn :bnext<cr>
nnoremap gp :bprevious<cr>

"Add re-run last command
nnoremap <leader>r :<Up><cr>
vnoremap <leader>r <Esc>:<Up><cr>

"Close all other buffers
nnoremap <leader>d mA:%bd<cr><C-W>v<C-W>v'A

" Open recent build failures
nnoremap <leader>q :cfile build/log<cr>

" Reload all windows"
nnoremap <leader>r :windo e!<cr>

"Autogroups

augroup code_file_types
    autocmd!
    autocmd FileType C set nospell
    autocmd FileType python set nospell
    autocmd FileType diff set nospell
    autocmd FileType qf set nospell
augroup END

augroup type_script_is_js
    autocmd!
    autocmd BufNewFile,BufRead *.ts   set filetype=javascript
augroup END

augroup txt_file_types
    autocmd!
    autocmd FileType text set spell spelllang=en_us
augroup END

augroup resize_split_on_win_resize
    autocmd!
    autocmd VimResized * wincmd =
augroup END

augroup tsx_is_javascript
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=javascript
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


"                                                                __ _
"  __ _ ___ _   _ _ __   ___ _ __ _   _ _ __     ___ ___  _ __  / _(_) __ _
" / _` / __| | | | '_ \ / __| '__| | | | '_ \   / __/ _ \| '_ \| |_| |/ _` |
"| (_| \__ \ |_| | | | | (__| |  | |_| | | | | | (_| (_) | | | |  _| | (_| |
" \__,_|___/\__, |_| |_|\___|_|   \__,_|_| |_|  \___\___/|_| |_|_| |_|\__, |
"           |___/                                                     |___/
" FIGLET: asyncrun config
"
let g:asyncrun_bell=1


"
"bClose script settings
"
let bclose_multiple = 1


"
" FUNCTIONS
"

function! Project_search(pattern, path)
    echom "path: " a:path " pattern: " a:pattern
    let @p = a:path
    let @q = a:pattern
    call ag#Ag('grep','-S ' . a:pattern . ' ' . a:path)
endfunction

"
" Shell commands open buffered window
"
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright 10new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  silent execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

command! -complete=shellcmd -nargs=+ ShellSync call s:RunShellCommand(<q-args>)
command! -complete=shellcmd -nargs=+ Shell :AsyncRun <args>
command! -complete=file -nargs=* Hg :AsyncRun hg <args>
command! -complete=file -nargs=* Gulp :AsyncRun gulp  <args>
command! -complete=file -nargs=* Build :AsyncRun build <args>
command! -complete=file -nargs=* CR :AsyncRun ./check_run.py <args>
command! -complete=file -nargs=* Lint :AsyncRun lint/all <args>


"
" QUMULO Specific stuff
"

" Qumulo Color Matching

" _var definitions
syn match qVar "\v\k+_var>"
syn match qPtrVarNull "\v\k+ptr_var_null>"
syn match qPtrVarRef "\v\k+ptr_var_ref>"
hi def link qVar Type
hi def link qPtrVarNull Type
hi def link qPtrVarRef Type

" global variables
syn keyword qGlobalVar global_variable
hi def link qGlobalVar Type

" foreach loops
syn keyword qForeachSingle foreach
hi def link qForeachSingle Repeat

" restart loops
syn match qRestartLoop "\v\k+_run_restartable>"
hi def link qRestartLoop Repeat

" with
syn keyword qWith with with_scope with_transaction
hi def link qWith Label

" patch
syn keyword qPatchable PATCHABLE
hi def link qPatchable Statement

" GENERATE
syn keyword qGen GENERATE a_generate module_define module_define_for_file linker_set_requires STRINGIFY
hi def link qGen Statement

" error handling
syn keyword qErr epanic ereturn eignore eretry eforward
syn keyword qIfErr if_error
hi def link qErr Statement
hi def link qIfErr Conditional

" test
syn keyword qTEST TEST FIXTURE_SET_UP FIXTURE_TEAR_DOWN
hi def link qTEST Type

" compiler flags
syn keyword qFLAGS a_warn_unused_result a_aligned a_packed a_transparent_union a_unused a_used a_cleanup a_section a_always_inline a_format_qumulo a_no_inline a_warn_unused_result a_weak a_interface_method a_const a_pure a_malloc a_getter a_setter a_implements a_implements_synchronized 
hi def link qFLAGS Label

" asserts
syn keyword qASSERTS assert assert_false assert_implies assert_iff panic not_reached assert_equal assert_not_equal assert_less assert_not_less assert_less_equal assert_not_less_equal assert_greater assert_not_greater assert_greater_equal assert_not_greater_equal assert_between_exclusive assert_between_inclusive assert_equal_epsilon assert_matches assert_null assert_not_null assert_empty assert_not_empty assert_size assert_valid assert_not_valid assert_bytes_equal assert_contains assert_not_contains assert_locked assert_unlocked assert_rlocked assert_wlocked assert_runlocked assert_wunlocked assert_contains_set assert_mutually_exclusive assert_subset assert_not_subset assert_superset assert_not_superset assert_disjoint assert_not_disjoint must_be_true must_be_false must_not_be_null assert_debug assert_xor assert_error_is_class
hi def link qASSERTS Statement


" backups are a little silly when you're using patches constantly
set nobackup
set noswapfile


"  ___                        _
" / _ \ _   _ _ __ ___  _   _| | ___
"| | | | | | | '_ ` _ \| | | | |/ _ \
"| |_| | |_| | | | | | | |_| | | (_) |
" \__\_\\__,_|_| |_| |_|\__,_|_|\___/
"                             _                 _
" _ __ ___   __ _ _ __  _ __ (_)_ __   __ _ ___( )
"| '_ ` _ \ / _` | '_ \| '_ \| | '_ \ / _` / __|/
"| | | | | | (_| | |_) | |_) | | | | | (_| \__ \
"|_| |_| |_|\__,_| .__/| .__/|_|_| |_|\__, |___/
"                |_|   |_|            |___/
" FIGLET: Qumulo mappings'
"

"Set F5 to run tests in the directory of the file in the current buffer
nnoremap <F5> :AsyncRun ./check_run.py -b '%:.:h'<cr>


" Qumulo Style end
