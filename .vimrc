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

" plugins下のディレクトリをruntimepathへ追加する。
for s:path in split(glob($VIM.'/plugins/*'), '\n')
  if s:path !~# '\~$' && isdirectory(s:path)
    let &runtimepath = &runtimepath.','.s:path
  end
endfor
unlet s:path

"filetype off
"filetype plugin indent off
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
  call dein#begin(s:dein_dir)
"  call dein#begin('C:\Users\nao\.vim\dein')
  " Check cache
"  if dein#load_cache()

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
"    call dein#save_cache()
"  endif

  call dein#end()

  " Installation check.
  if dein#check_install()
    call dein#install()
  endif
endif
" vimprocをダンロードする設定を追加
let g:vimproc#download_windows_dll=1

let mapleader = "\<Space>"
"unite mode with starting insert mode.
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_file_mru_limit=200
if s:dein_enabled && dein#tap("unite.vim")
  nnoremap [unite] <Nop>
  nmap <Leader>f [unite]
  nnoremap <silent> [unite]b :Unite buffer<CR>
  nnoremap <silent> [unite]f :Unite file<CR>
  nnoremap <silent> [unite]a :Unite bookmark<CR>
  nnoremap <silent> [unite]m :Unite file_mru buffer<CR>
  nnoremap <silent> [unite]n :Unite file/new<CR>
  nnoremap <silent> [unite]y :Unite history/yank<CR>
endif

"filetype plugin indent on
"filetype on
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

"======indent setting======
set tabstop=2
set smartindent "auto indent
set expandtab "use space instead of tab
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
"===========================


"====== mouse setting ======
set mouse=a
set nomousefocus
set mousehide
"===========================
colorscheme molokai

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
