" vi: set ts=4 sw=4 noet

" === UI
"set background=dark
set background=light
"colorscheme desert
colorscheme solarized
set cmdheight=1
"set laststatus=0

"set guioptions-=T
"set guioptions-=m
"set guioptions-=r
"set guioptions-=L
set guioptions=

if has("win32") || has("win64")
	set guifont=Ricty\ Discord\ Regular:h12
else
	set guifont=Ricty\ Discord\ Regular:h14
endif

set titlestring=GVim\ -\ %F%m%r%h%w\ %{fugitive#statusline()}\ %y\[%{&ff}]\[%{&fileencoding}][%Bh][%l/%L]
