set nocompatible
filetype off

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#begin(expand('~/.vim/bundle/'))
	NeoBundleFetch 'Shougo/neobundle.vim'
	call neobundle#end()
endif

if !has('gui_running')
	set t_Co=256
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'VimClojure'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'rking/ag.vim'

NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-surround.git'
NeoBundle 'open-browser.vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'groenewege/vim-less'
NeoBundle 'heavenshell/vim-jsdoc'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
NeoBundle 'stephpy/vim-yaml'

NeoBundle 'itchyny/lightline.vim'

NeoBundle 'yuroyoro/yuroyoro256.vim'

NeoBundle 'myhere/vim-nodejs-complete'

filetype plugin indent on
filetype indent on
syntax on

colorscheme yuroyoro256

set nobackup
set noswapfile
set tabstop=4
set shiftwidth=4
set smartindent
set autoindent
set noexpandtab
set scrolloff=5
set textwidth=0
set autoread
set backspace=indent,eol,start
set formatoptions=lmoq
set vb t_vb=
set showcmd
set showmode
set clipboard+=unnamed
set number
set hlsearch
set wrapscan
set ignorecase
set smartcase
set incsearch
set cursorline
set noundofile
set laststatus=2
autocmd VimEnter,Colorscheme * :hi Cursorline cterm=underline ctermbg=234

set list
set listchars=tab:▸\ ,extends:›,precedes:‹

nnoremap OA gi<Up>
nnoremap OB gi<Down>
nnoremap OC gi<Right>
nnoremap OD gi<Left>
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

nnoremap <Down> gj
nnoremap <Up> gk

set noimdisable
set iminsert=0 imsearch=0
set noimcmdline

set wildmenu
set wildchar=<tab>
set wildmode=list:full
set history=1000

inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

autocmd BufWritePre * :%s/\s\+$//ge

set foldlevelstart=99

let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
let g:neocomplete#enable_insert_char_pre=1

autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CombleteJS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CombleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CombleteCSS
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.javascript = ['nodejscomplete#CompleteJS', 'javascriptcomplete#CompleteJS']
let g:lightline={
			\ 'colorscheme': 'wombat'
			\ }

let g:syntastic_javascript_checkers = ['jsxhint']

augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

noremap ; :
