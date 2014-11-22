"Use plugins vim-surround, vim-commentary, Command-T, vim-unimpaired
"Use colorscheme vim-kolor
"Optional vim-perv-startify
"Manage with pathogen
execute pathogen#infect()
set nocompatible "Don't use compatibility mode
colorscheme kolor

"use mouse (for resizing, in normal mode only! Because the %#$&ing touchpad on
"a laptop is so close to the spacebar it screws up typing in insert mode)
set mouse=
set ttymouse=xterm2 "for whatever reason you have to do this to resize windows in vim within tmux

"Use ack-grep to replace grep
set grepprg=ack-grep\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

"Use :help for K
set keywordprg=
set winwidth=79 "So it's more bearable to read
set autoread "Automatically read files if modified outside of vim
set switchbuf=useopen "REALLY useful, doesn't screw up file layout
set tabstop=4 "How many columns a tab actually is displayed
set softtabstop=4 
"This is pure B.S. Why would I wanna do otherwise? Make sure tabstop = softabstop
"Don't be a $%@^# and screw up your own formatting
set shiftwidth=4 "How many spaces <</>> or autoindent will use
set noexpandtab "Don't expand tabs ever
set autoindent "Autoindent, don't use smartindent/cindent because of filetype indent
filetype plugin indent on "Reads indentation file
syntax on "Displays syntax
" set foldmethod= "Fold based on syntax

set number "Numbering
set ignorecase smartcase infercase "So there's no need to type Caps for searching, saves time. Also makes sure that Caps do get read, and autocomplete are inferred
set complete=.,i,d,t,w,b
set hidden "In humanspeak, you don't have to be prompted every time you load from an unsaved buffer.
set is "Incremental search. So useful. Used for <C-a>/<C-x>.
"treat everything as decimals
set nrformats=
"Match longest satisfying and list all matches
set wildmode=longest,list
"Open window at the bottom or right
set splitbelow splitright
"Delete everything with backspace
set bs=indent,eol,start
"Show operator pending commands
set showcmd

"Mappings
"
"Leader Mappings
let mapleader = "," "used for easier typing
"Quickly change vimrc, it's more of a temporary setting
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
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
let g:CommandTInputDebounce = 100
let g:CommandTAcceptSelectionMap = ['<CR>', '<Space>']
let g:CommandTAlwaysShowDotFiles = 1
let g:CommandTBackspaceMap = ['<BS>', '<C-h>']
let g:CommandTAcceptSelectionVSplitMap = ['<S-CR>', '<C-v>']
let g:CommandTCursorLeftMap = ['<Left>']
let g:CommandTCancelMap=['<C-[>', '<C-c>', '<Esc>']

"Mappings to open split windows
nnoremap <silent> <leader>w :new<CR>
nnoremap <silent> <leader>v :vne<CR>

"Maps %% to current file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
nmap <leader>e :edit %%

"Other Maps
nnoremap <C-j> o<Esc>k
nnoremap <C-k> O<Esc>j
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
inoremap <C-k> <c-p>
inoremap <C-j> <c-n>
nnoremap <f5> :!ctags -R<cr><cr>

"Use *, # in visual mode for selection search
function! s:VSetSearch()
	let temp = @s
	norm! gv"sy
	let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
	let @s = temp
endfunction

xnoremap * :<c-u>call <SID>VSetSearch()<CR>/<c-r>=@/<CR><CR>
xnoremap # :<c-u>call <SID>VSetSearch()<CR>?<c-r>=@/<CR><CR>

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

"Use autocmd for library tag completion, still searching for better solution
" if has('autocmd')
" 	autocmd FileType c setlocal tags+=~/.vim/systags
" 	autocmd FileType cpp setlocal tags+=~/.vim/qttags
" endif
	
"Don't really need that much history
set history=30
"Use % to switch between open and close structures, #if/#endif etc.
runtime macros/matchit.vim
"Turn on omnicompletion
"set omnifunc=syntaxcomplete#Complete
"Because <C-x><C-o> is literally the worst mapping for completion
"imap <leader><Tab> <C-x><C-o>

"This part is to screw with people who still use arrow keys :D
nnoremap <Up> :echo "@#$% you!!"<CR>
nnoremap <Down> :echo "@#$% you!!"<CR>
nnoremap <Right> :echo "@#$% you!!"<CR>
nnoremap <Left> :echo "@#$% you!!"<CR>

"Perverted startify options
let g:pstart_enable=1
let g:pstart_header=map(split(system('cat ~/commands.txt'), '\n'), 'v:val') + ['', '']
let g:pstart_footer=map(split(system('fortune | cowthink -f tux'), '\n'), '"   ". v:val') + ['','']

"Emmet(Zencoding) Options
let g:user_emmet_install_global=0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key='<C-y>'

augroup vimrcEx
	autocmd!
	autocmd FileType python set sw=4 sts=4 ts=4 et
augroup END

let g:user_emmet_settings = webapi#json#decode(join(readfile(expand('~/.vim/bundle/emmet-vim/snippets.json')), "\n"))
