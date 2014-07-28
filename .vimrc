"Use plugins vim-surround, vim-commentary, Command-T, vim-unimpaired
"Manage with pathogen
execute pathogen#infect()
set nocompatible "Don't use compatibility mode

"use mouse (for resizing, in normal mode only! Because the %#$&ing touchpad on
"a laptop is so close to the spacebar it sCRews up typing in insert mode)
set mouse=n
set ttymouse=xterm2 "for whatever reason you have to do this to resize windows in vim within tmux

set autoread "Automatically read files if modified outside of vim
set switchbuf=useopen "REALLY useful, doesn't sCRew up file layout
set tabstop=4 "How many columns a tab actually is displayed
set softtabstop=4 
"This is pure B.S. Why would I wanna do otherwise? Make sure tabstop = softabstop
"Don't be a $%@^# and sCRew up your own formatting
set shiftwidth=4 "How many spaces <</>> or autoindent will use
set noexpandtab "Don't expand tabs ever
set autoindent "Autoindent, don't use smartindent/cindent because of filetype indent
filetype plugin indent on "Reads indentation file
syntax on "Displays syntax

set number "Numbering
set ignorecase smartcase "So there's no need to type Caps for searching, saves time. Also makes sure that Caps do get read
set hidden "In humanspeak, you don't have to be prompted every time you load from an unsaved buffer.
set is "InCRemental search. So useful. Used for <C-a>/<C-x>.
"treat everything as decimals
set nrformats=
"Adds current file directory as search path.
set path+=%:h

"Mappings
"
"Leader Mappings
let mapleader = "," "used for easier typing
"Quickly switches to previous file
nnoremap <leader><leader> <c-^> 
"Quick make
nnoremap <silent> <leader>m :mak<CR><CR><CR>:cwin<CR>

"Quickfix Toggling, stolen and modified from Gary Bernhardt
function! GetBufferList()
	redir =>buflist
	silent! ls
	redir END
	return buflist
endfunction

function! BufferIsOpen(bufname)
	let buflist = GetBufferList()
	for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
		if bufwinnr(bufnum) != -1
			return 1
		endif
	endfor
	return 0
endfunction
									  
function! ToggleQuickfix()
	if BufferIsOpen("Quickfix List")
		cclose
	else
		cwin
	endif
endfunction

nnoremap <silent> <leader>q :call ToggleQuickfix()<CR>
nnoremap <silent> <leader>j :cnext<CR>
nnoremap <silent> <leader>k :cprev<CR>

"Use ,f for fuzzy search
nnoremap <silent> <leader>f :CommandT<CR>

"Mappings to open split windows
nnoremap <silent> <leader>w :new<CR><c-w>J
nnoremap <silent> <leader>v :vne<CR><c-w>L

"Use Esc for closing
let g:CommandTCancelMap=['<C-[>', '<C-c>', '<Esc>']
"Maps %% to current file directory
cnoremap %% <C-R>=expand('%:h').'/'<CR>
nnoremap <leader>e :edit %%

"Other Maps
nmap <C-j> o<Esc>k
nmap <C-k> O<Esc>j
cmap <C-k> <Up>
cmap <C-j> <Down>

"TAB Completion
"Indent if at beginning of a line, otherwise autocompletes, 
"stolen from Gary Bernhardt.
function! InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<tab>"
	else
		return "\<c-p>"
	endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<CR>
inoremap <s-tab> <c-n>

"Use predefined ctags file for standard libraries. In retrospect not such a
"great idea. Remove?
set tags+=~/.vim/systags,~/.vim/qttags
"Don't really need that much history
set history=30
"Use % to switch between open and close structures, #if/#endif etc.
runtime maCRos/matchit.vim
"Turn on omnicompletion
set omnifunc=syntaxcomplete#Complete
"Because <C-x><C-o> is literally the worst mapping for completion
"imap <leader><Tab> <C-x><C-o>

