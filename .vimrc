set nocompatible
filetype off

if has('vim_starting')
	set rtp+=~/.vim/plugged/vim-plug
	if !isdirectory(expand('~/.vim/plugged/vim-plug'))
		echo 'install vim-plug...'
		call system('mkdir -p ~/.vim/plugged/vim-plug')
		call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/plugged/vim-plug/autoload')
	end
endif

call plug#begin('~/.vim/plugged')

	Plug 'Shougo/vimproc'
	Plug 'VimClojure'
	Plug 'Shougo/vimshell'
	Plug 'Shougo/unite.vim'
	Plug 'Shougo/neocomplete.vim'
	Plug 'Shougo/neosnippet'
	Plug 'Shougo/neosnippet-snippets'
	Plug 'jpalardy/vim-slime'
	Plug 'majutsushi/tagbar'
	Plug 'rking/ag.vim'

	Plug 'neomake/neomake'
	Plug 'benjie/neomake-local-eslint.vim'

	Plug 'mattn/emmet-vim'
	Plug 'tpope/vim-surround'
	Plug 'open-browser.vim'
	Plug 'mattn/webapi-vim'
	Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'less'] }
	Plug 'osyo-manga/vim-over'
	Plug 'digitaltoad/vim-jade', { 'for': ['jade'] }
	Plug 'mustache/vim-mustache-handlebars', { 'for': ['html.handlebars'] }
	Plug 'groenewege/vim-less', { 'for': ['less'] }
	Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx' ] }
	Plug 'heavenshell/vim-jsdoc', { 'for': ['javascript'] }
	Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx'] }
	Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
	Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
	Plug 'stephpy/vim-yaml', { 'for': ['yaml'] }
	Plug 'keith/swift.vim', { 'for': ['swift'] }
	Plug 'tpope/vim-fugitive'

	Plug 'itchyny/lightline.vim'

	Plug 'tomasr/molokai'

	Plug 'myhere/vim-nodejs-complete'

call plug#end()

if !has('gui_running')
	set t_Co=256
endif

filetype plugin indent on
filetype indent on
syntax on

colorscheme molokai
highlight Normal ctermbg=none

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
set rtp+=/usr/local/opt/fzf
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

autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']

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
let g:lightline = {
	\ 'active': {
	\     'left': [ ['mode' ], [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'colorscheme': 'wombat',
	\ 'component_function': {
	\     'readonly': 'LightLineReadonly',
	\     'fugitive': 'LightLineFugitive'
	\ }
	\ }

function! LightLineReadonly()
	if &filetype == "help"
		return ""
	elseif &readonly
		return "⭤"
	else
		return ""
	endif
endfunction

function! LightLineFugitive()
	if exists("*fugitive#head")
		let _ = fugitive#head()
		return strlen(_) ? '⭠ '._ : ''
	endif
	return ''
endfunction


" syntastic settings
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_enable_signs = 1
"let g:syntastic_always_populate_loc_list = 0
"let g:syntastic_auto_loc_list = 0
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

let g:user_emmet_jsx = 1
let g:jsx_ext_required = 0

let g:used_javascript_libs = 'jquery,underscore,backbone,react,flux,handlebars'

augroup VimJsxPretty
  autocmd!
  autocmd VimEnter *.js,*.jsx highlight jsNoise ctermfg=197 cterm=bold guifg=#F92672 gui=bold
  autocmd VimEnter *.js,*.jsx highlight jsArrowFunction ctermfg=197 cterm=bold guifg=#F92672 gui=bold
  autocmd VimEnter *.js,*.jsx highlight jsObjectBraces ctermfg=197 cterm=bold guifg=#F92672 gui=bold
  autocmd VimEnter *.js,*.jsx highlight jsFuncBraces ctermfg=118 guifg=#A6E22E
  autocmd VimEnter *.js,*.jsx highlight jsFuncCall ctermfg=228 guifg=#A6A5AE
  autocmd VimEnter *.js,*.jsx highlight jsBrackets cterm=bold gui=bold
augroup END

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

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
