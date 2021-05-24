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
" Add tags inside of /usr/include
set tags+=/usr/include/**/.tags
set tags+=/usr/lib/python*/.tags
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
set colorcolumn=80,88,120
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
au FileType gitcommit set tw=72
au FileType hgcommit set tw=72


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

" __     ___    ____ _____
" \ \   / / \  / ___|_   _|
"  \ \ / / _ \ \___ \ | |
"   \ V / ___ \ ___) || |
"    \_/_/   \_\____/ |_|
"  FIGLET: VAST
" Rsync to Azure dev-vm and build
nnoremap <f5> :Shell /home/mkirby/my_tools/vast-build-helpers/sync-and-build-on-azure<cr>



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

augroup scons_is_python
    autocmd!
    autocmd BufNewFile,BufRead SConstruct set filetype=python
augroup END

"
" vim-plug settings (https://github.com/junegunn/vim-plug)
"
call plug#begin('~/.vim/plugged')

" Use ack.vim for quick search + ripgrep underneath the covers
Plug 'mileszs/ack.vim'
let g:ackprg = 'rg --vimgrep -S'
nnoremap gn :cn<cr>
nnoremap gp :cp<cr>

" Enable fzf inside of vim
Plug '~/.fzf'
nnoremap <leader>o :FZF<cr>

call plug#end()

"
" Ripgrep remember last search and last path
"
nnoremap <leader>f <Esc>:Ack! 
vnoremap <leader>f y<Esc>:Ack! <C-R>"

"
" FUNCTIONS
"

function! DNotes()
    let year = system('date +%Y')[:-2]
    let month =  system('date +%B')[:-2]
    let day = system('date +%d')[:-2]
    let open_path = "/home/mkirby/daily-notes/" . year . "/" . month . "/" . day . ".notes"
    execute "e " . open_path
endfunction
nnoremap <leader>q <Esc>:call DNotes()<cr>

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
