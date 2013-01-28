" vi:set ts=4 sw=4 noet:
" bundle

set nocompatible
filetype off

if has("vim_starting")
	set rtp+=~/dotfiles/vimfiles/bundle/neobundle.vim
	call neobundle#rc("~/dotfiles/vimfiles/bundle")
endif

NeoBundle "Shougo/neobundle.vim"

NeoBundle "Shougo/neocomplcache"
NeoBundle "Shougo/neosnippet"
NeoBundle "Shougo/unite.vim"
NeoBundle "Shougo/vimproc"
NeoBundle "Shougo/vimfiler"
NeoBundle "Shougo/vimshell"
NeoBundle "tpope/vim-surround"
NeoBundle "tpope/vim-fugitive"
NeoBundle "gregsexton/gitv"
NeoBundle "mattn/zencoding-vim"
NeoBundle "mattn/webapi-vim"
NeoBundle "mattn/gist-vim"
NeoBundle "tsaleh/vim-matchit"
NeoBundle "thinca/vim-qfreplace"
NeoBundle "thinca/vim-quickrun"
NeoBundle "fuenor/qfixhowm"
NeoBundle "fuenor/qfixgrep"
NeoBundle "altercation/vim-colors-solarized"
NeoBundle "Lokaltog/vim-powerline"
NeoBundle "majutsushi/tagbar"

syntax on
filetype plugin indent on

" end of bundle

" === encoding
language message C
set ambiwidth=double
if has('win32') || has('win64')
	"set encoding=cp932
	set encoding=utf-8
	set fileencodings=cp932,utf-8,iso-2022,euc-jp,ucs21e,ucs-2,latin1
else
	set encoding=utf-8
	set fileencodings=utf-8,cp932,iso-2022,euc-jp,ucs21e,ucs-2,latin1
endif

" === path
if has('win32') || has('win64')
	if $COMPUTERNAME=="NIAGARA"
		set backupdir=d:/Dropbox/temp
	endif
	set directory=c:/tmp,d:/tmp,.
endif

" === UI
if !has('gui')
	set background=light
	"colorscheme desert
	colorscheme solarized
endif
set laststatus=2
"set statusline=%F%m%r%h%w\ %{fugitive#statusline()}%=%y\[%{&ff}]\[%{&fileencoding}][%Bh][%l/%L]

" === powerline
let g:Powerline_symbols = 'unicode'
"let g:Powerline_theme = 'skwp'
"let g:Powerline_colorscheme = 'skwp'

" === Vim
set tabstop=2
set shiftwidth=2
set noexpandtab
set visualbell
if has('win32') || has('win64')
	set grepprg=jvgrep
endif

if has('path_extra')
	set tags+=tags;
endif

let mapleader = ","
nmap <Leader>w0 :set lines=999 columns=999<CR>
nmap <Tab> <C-w>w
nmap <S-Tab> <C-w>p
nmap <C-Tab> gt
nmap <C-S-Tab> gT

" === vimdiff
set diffopt=filler,iwhite
nmap <Leader>dt :diffthis<CR>
nmap <Leader>du :diffupdate<CR>

" === fugitive
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader>gb :Gblame<CR>

" === neocomplcache
let g:neocomplcache_enable_at_startup = 1

inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return neocomplcache#smart_close_popup() . "\<CR>"
	" For no inserting <CR> key.
	"return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ?
 \ "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif

" === Unite
call unite#custom_default_action('source/bookmark/directory', 'vimfiler')
let g:unite_source_file_mru_limit=500
nmap <Leader>u :UniteResume<CR>
nmap <Leader>uu :UniteResume<CR>
nmap <Leader>ua :Unite buffer file_mru<CR>
nmap <Leader>uf :Unite file_mru<CR>
nmap <Leader>ub :Unite buffer<CR>
nmap <Leader>um :Unite bookmark<CR>
nmap <Leader>s :Unite snippet<CR>

" === VimFiler
nmap <Leader>f :VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
nmap <Leader>ff :VimFiler -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>
nmap <Leader>fb :VimFilerBufferDir -buffer-name=explorer -split -simple -winwidth=35 -toggle -no-quit<CR>

augroup vimrc
  autocmd FileType vimfiler call s:vimfiler_my_settings()
augroup END
function! s:vimfiler_my_settings()
  nmap <buffer> <Tab> <C-w>w
endfunction

" === gist-vim
let g:gist_show_privates = 1
let g:gist_post_private = 1

" === quickrun
let g:quickrun_config = {}
if $COMPUTERNAME=="NIAGARA"
	let g:quickrun_config.php = {'command' : 'c:\Develop\xampp\php\php.exe'}
else
	let g:quickrun_config.php = {'command' : 'php'}
endif
vmap <Leader>r <Plug>(quickrun)
nmap <Leader>r <Plug>(quickrun)

" === Howm
let QFixHowm_Key = ','
if $COMPUTERNAME=="NIAGARA"
	let howm_dir = 'D:/Dropbox/howm'
endif
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.txt'
let howm_fileencoding = 'utf-8'
let howm_fileformat = 'unix'
let calender_jp = 0
if has('win32') || has('win64')
	let mygrepprg = 'jvgrep'
endif
let QFixHowm_ReminderPriority = {'@' : 1, '!' : 1, '+' : 3, '-' : 4, '~' : 5, '.' : 6}
let QFixHowm_ListReminder_ScheExt = '[-@+!~]'

" === filetype

" PHP
augroup PHP
	autocmd!
	if $COMPUTERNAME=="NIAGARA"
		autocmd FileType php setlocal makeprg=c:/Develop/xampp/php/php.exe\ -ln\ %
	else
		autocmd FileType php setlocal makeprg=php\ -ln\ %
	endif
	autocmd FileType php setlocal errorformat=%m\ in\ %f\ on\ line\ %l
	autocmd BufWritePost *.php silent make | if len(getqflist()) != 1 | copen | else | cclose | endif
augroup END
