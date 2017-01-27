"====== encoding setting ======
set encoding=utf-8
set fileencodings=utf-8,sjis
set fileformats=unix,dos,mac
"if &encoding !=# 'utf-8'
"  set encoding=japan
"  set fileencoding=japan
"endif
"==============================
scriptencoding utf-8
" set encoding はscriptencodingより前に記述しなければならない

" Flags
let s:use_dein = 1

" vi compatibility
if !&compatible
  set nocompatible
endif

" Prepare .vim dir
let s:vimdir = $HOME . "/.vim"
if has("vim_starting")
  if ! isdirectory(s:vimdir)
    call system("mkdir " . s:vimdir)
  endif
endif

" hook用
augroup MyAutoCmd
    autocmd!
augroup END

" dein
let s:dein_enabled  = 0
if s:use_dein && v:version >= 704
  let s:dein_enabled = 1

  " Set dein paths
  let s:dein_dir = s:vimdir . '/dein'
  let s:dein_github = s:dein_dir . '/repos/github.com'
  let s:dein_repo_name = "Shougo/dein.vim"
  let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

  " Check dein has been installed or not.
  if !isdirectory(s:dein_repo_dir)
    echo "dein is not installed, install now "
    let s:dein_repo = "https://github.com/" . s:dein_repo_name
    echo "git clone " . s:dein_repo . " " . s:dein_repo_dir
    call system("git clone " . s:dein_repo . " " . s:dein_repo_dir)
  endif
  let &runtimepath = &runtimepath . "," . s:dein_repo_dir
  " Begin plugin part
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
  " Check cache
  "if dein#load_cache()

    call dein#add('Shougo/dein.vim')

    call dein#add('Shougo/neomru.vim')

    call dein#add('Shougo/vimproc', {
          \ 'build': {
          \     'windows': 'tools\\update-dll-mingw',
          \     'cygwin': 'make -f make_cygwin.mak',
          \     'mac': 'make -f make_mac.mak',
          \     'linux': 'make',
          \     'unix': 'gmake'}})

    call dein#add('Shougo/unite.vim', {
          \ 'depends': ['vimproc'],
          \ 'on_cmd': ['Unite'],
          \ 'lazy': 1})

    call dein#add('Shougo/vimfiler.vim')

    if has('lua')
      call dein#add('Shougo/neocomplete.vim', {
            \ 'on_i': 1,
            \ 'lazy': 1})

      call dein#add('ujihisa/neco-look', {
            \ 'depends': ['neocomplete.vim']})
    endif

    call dein#add('tyru/open-browser.vim', {
          \ 'on_map': ['<Plug>(openbrowser-smart-search)'],
          \ 'lazy': 1})

    call dein#add('tomasr/molokai')
    call dein#add('fsouza/cobol.vim')
    call dein#add('scrooloose/nerdtree')
    call dein#add('itchyny/lightline.vim')
    "call dein#add('nathanaelkane/vim-indent-guides')
    call dein#add('Yggdroot/indentLine')
    call dein#add('tpope/vim-surround')
    call dein#add('ctrlpvim/ctrlp.vim')
    call dein#add('Townk/vim-autoclose')
    call dein#add('tpope/vim-fugitive')
    "call dein#save_cache()
  "endif

    call dein#end()
    call dein#save_state()
  endif

  " Installation check.
  if dein#check_install()
    call dein#install()
  endif
endif

" vimprocをダンロードする設定を追加
let g:vimproc#download_windows_dll=1

let mapleader = "\<Space>"

if dein#tap('unite.vim')
    function! s:unite_on_source() abort
        call unite#custom#default_action('source/bookmark/directory','vimfiler')
    endfunction

    execute 'autocmd MyAutoCmd User' 'dein#source#' . g:dein#name
        \ 'call s:unite_on_source()'
endif
"unite mode with starting insert mode.
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_file_mru_limit=200
nnoremap [unite] <Nop>
nmap <Leader>f [unite]
nnoremap <silent> [unite]b :Unite buffer<CR>
"nnoremap <silent> [unite]f :Unite file<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]a :Unite bookmark<CR>
nnoremap <silent> [unite]m :Unite file_mru buffer<CR>
nnoremap <silent> [unite]n :Unite file/new<CR>
nnoremap <silent> [unite]y :Unite history/yank<CR>

let s:undo_dir=$VIM . "/undo"
if ! isdirectory(s:undo_dir)
  call system("mkdir " . s:undo_dir)
endif
let &undodir = s:undo_dir

"show line number
set number

let s:backup_dir=$VIM . "/backupfile"
if ! isdirectory(s:backup_dir)
  call system("mkdir " . s:backup_dir)
endif
"backup file directory
let &backupdir=s:backup_dir
"color theme
syntax on
colorscheme molokai

set autoread
set confirm
set hidden

"======indent setting======
set tabstop=4
set shiftwidth=4
set softtabstop=2
set smartindent "auto indent
set expandtab "use space instead of tab
"indent-line
let g:indentLine_enabled = 1
let g:indentLine_color_term = 111
let g:indentLine_color_gui = '#708090'
let g:indentLine_char = '|'
"==========================

" not make swap file
set noswapfile
"====== show setting ======
"show title
set title
" show invisible char
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<,eol:$
"auto formatting
set formatoptions=q
set showmatch "emphasize the brackets of the pair
autocmd FocusGained * set transparency=0
autocmd FocusLost * set transparency=0
set nocursorcolumn
set nocursorline

" カーソル行をハイライト
" set cursorline
" hi cursorline term=reverse cterm=none ctermbg=232 ctermfg=NONE
" hi Cursor guifg=black ctermfg=black ctermbg=black
" hi Comment ctermfg=27
" 
" "カレントウィンドウにのみ罫線を引く
" augroup cch
" autocmd! cch
"  autocmd WinLeave * set nocursorline
"  autocmd WinEnter,BufRead * set cursorline
" augroup END
"==========================

"command line auto complete with tab key
set wildmenu

"====== search setting======
set ignorecase "not case-sensitive
"set smartcase "if keyword has uppercase , become case-sensitive
set wrapscan "back to top
" clear result search
nnoremap <ESC><ESC> :nohlsearch<CR>
" result hilight
set hlsearch
set incsearch
"===========================

"====== mouse setting ======
set mouse=a
set nomousefocus
set mousehide
"===========================

" フォント設定:
"
if has('win32')
  " Windows用
  "set guifont=MS_Gothic:h12:cSHIFTJIS
  set guifont=IPAゴシック:h12:cSHIFTJIS:qDRAFT
  "set guifont=MS_Mincho:h12:cSHIFTJIS
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  set guifont=Osaka－等幅:h14
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endif

"====== keymapping setting ======
nnoremap あ a
nnoremap い i
nnoremap う u
nnoremap お o
nnoremap っd dd
nnoremap っy yy
nnoremap っｄ dd
nnoremap っｙ yy
nnoremap ｄｄ dd
nnoremap ｙｙ yy
" ""の中身を変更する
nnoremap し” ci"
" ''の中身を変更する
nnoremap し’ ci'
" jjでエスケープ
inoremap <silent> jj <ESC>
" 日本語入力で”っj”と入力してもEnterキーで確定させればインサートモードを抜ける
inoremap <silent> っj <ESC>
inoremap <silent> っｊ <ESC>
inoremap <silent> ｊｊ <ESC>
" 入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
"================================

""""""""""""""""""""""""""""""
"NERDTreeの設定

""""""""""""""""""""""""""""""
""bookmarkを初期表示
"let g:NERDTreeShowBookmarks=1
"
"" NERDTreeの自動起動
"autocmd vimenter * NERDTree
"
"" ファイル名指定でのVim起動時は表示しない
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"
"" キーバインド
"map <C-n> :NERDTreeToggle<CR>
"
"" 拡張子ごとにハイライト
"" NERDTress File highlighting
"function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
" exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
" exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
"endfunction
"
"call NERDTreeHighlightFile('py', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
"call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
"call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
"call NERDTreeHighlightFile('rb', 'Red', 'none', 'red', '#151515')
"call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
"call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
"" 拡張子ごとにハイライトおわり
"
" cobol
" autocmd BufNewFile,BufReadPost *.ccb, *.cpy, *.inc, *.cbl, *.cob set filetype=cobol
autocmd BufNewFile,BufReadPost *.ccb set filetype=cobol
autocmd BufNewFile,BufReadPost *.cpy set filetype=cobol
autocmd BufNewFile,BufReadPost *.inc set filetype=cobol
autocmd BufNewFile,BufReadPost *.cbl set filetype=cobol
autocmd BufNewFile,BufReadPost *.cob set filetype=cobol

" clipboard
set clipboard=unnamed

"====== neocomplete setting ======
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
let g:neocomplete#force_overwrite_completefunc = 1
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" 候補の1番目を選択状態でポップアップ
let g:neocomplete#enable_auto_select = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#max_list = 10
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
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"====== jvgrep setting ======
" grep をjvgrepに置き換える
set grepprg=jvgrep
"============================

filetype plugin indent on
filetype on

<<<<<<< HEAD
set backspace=indent,eol,start
=======
"===== tags ======
" ファイルタイプ毎にtagsの読み込みファイルを変える
function! ReadTags(type)
    execute "set tags=./." . a:type . "_tags;./.tags;"
endfunction

augroup TagsAutoCmd
    autocmd!
    autocmd BufEnter * :call ReadTags(&filetype)
augroup END

nnoremap <C-]> g<C-]>
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>
"==================

>>>>>>> 22d7260504375bfff7e9211a969b325a75ca69bd
