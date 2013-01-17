"--------------------------------
"システム設定
"--------------------------------
:set tags=tags
:set noswapfile

" F5を押した後、デバッグセッション開始までに待ってくれる秒数
let g:debuggerTimeout=10

" デバッグ開始時にセッションごとにVimのタブを起動する。
let g:debuggerDedicatedTab=1 

set nocompatible

set rtp+=~/.vim/vundle.git/
call vundle#rc()

Bundle 'vim-abolish'
Bundle 'vim-surround'
Bundle 'vim-copypath'
Bundle 'yuratomo/w3m.vim'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'mattn/zencoding-vim'
Bundle 'mattn/webapi-vim'
Bundle 'thinca/vim-quickrun'

filetype plugin indent on

"バッファをクリップボードと共有
set clipboard=unnamed

"Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>

"
" neocomplcache & neosnippet
"
"起動時に有効
let g:neocomplcache_enable_at_startup = 1
"補完候補が一つしかなくてもポップアップメニューを表示
set completeopt=menuone
"ポップアップメニューで表示される候補の数。初期値は100
let g:neocomplcache_max_list = 20
"改行で補完ウィンドウを閉じる
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

"スニペットファイルを編集する
nnoremap <Space>nes :NeoComplCacheEditSnippets

"タブ
set expandtab
set tabstop=4
set shiftwidth=4
"インデント
set autoindent
set smartindent
"バックアップ
set nobk
"Tags再帰検索
set tags=tags;
"ブロック選択
nnoremap vb /{<CR>%v%0
"PHP
let php_sql_query=1
let php_htmlInStrings=1
"カッコの自動入力
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ` ``<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>

"キーバインド変更
"C-jでコマンドモード
imap <C-j> <ESC>
"--------------------------------
"表示設定
"--------------------------------
"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END
"行数表示
set number
"改行文字・タブ・全角スペースを表示
set list
set listchars=tab:>-,eol:<
"色設定
colorscheme desert
"日本語入力ON時のカーソルの色を設定
if has('multi_byte_ime') || has('xim')
   highlight CursorIM guibg=LightCyan guifg=NONE
endif
"現在時間出力
function! Ntime()
    let now = localtime()
    return strftime("%H:%M:%S", now)
endfunction
imap <silent> <C-T><C-T> <C-R>=Ntime()<CR>

"unite prefix key.
nnoremap [unite] <Nop>
nmap <Space>u [unite]
 
"unite general settings
"インサートモードで開始
let g:unite_enable_start_insert = 1
"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 50
 
"file_mruの表示フォーマットを指定。空にすると表示スピードが高速化される
let g:unite_source_file_mru_filename_format = ''
 
"現在開いているファイルのディレクトリ下のファイル一覧。
"開いていない場合はカレントディレクトリ
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
"レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
"ブックマーク一覧
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
"ブックマークに追加
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
"uniteを開いている間のキーマッピング
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  "ESCでuniteを終了
  nmap <buffer> <ESC> <Plug>(unite_exit)
  "入力モードのときjjでノーマルモードに移動
  imap <buffer> jj <Plug>(unite_insert_leave)
  "入力モードのときctrl+wでバックスラッシュも削除
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  "ctrl+jで縦に分割して開く
  nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  "ctrl+jで横に分割して開く
  nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
  "ctrl+oでその場所に開く
  nnoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
  inoremap <silent> <buffer> <expr> <C-o> unite#do_action('open')
endfunction"}}}
