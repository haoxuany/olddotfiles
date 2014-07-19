"Use plugins vim-surround, vim-commentary, Command-T, vim-unimpaired
"Manage with pathogen
execute pathogen#infect()
set nocompatible "Don't use compatibility mode

"use mouse (for resizing, in normal mode only! Because the %#$&ing touchpad on
"a laptop is so close to the spacebar it screws up typing in insert mode)
set mouse=n

set autoread "Automatically read files if modified outside of vim
set tabstop=4 "How many columns a tab actually is displayed
set softtabstop=4 
"This is pure B.S. Why would I wanna do otherwise? Make sure tabstop = softabstop
"Don't be a $%@^# and screw up your own formatting
set shiftwidth=4 "How many spaces <</>> or autoindent will use
set noexpandtab "Don't expand tabs ever
set autoindent "Autoindent, don't use smartindent/cindent because of filetype indent
filetype plugin indent on "Reads indentation file
syntax on "Displays syntax

set number "Numbering
set ignorecase "So there's no need to type Caps for searching, saves time. Requirement for next setting.
set smartcase "So that when I DO type Caps, I mean it.
set hidden "In humanspeak, you don't have to be prompted every time you load from an unsaved buffer.
set is "Incremental search. So useful. Used for <C-a>/<C-x>.
"treat everything as decimals
set nrformats=
"Adds current file directory as search path.
set path+=%:h

"mappings
let mapleader = "," "used for easier typing of Command-T
map <F7> <Esc>mA:mak<CR><CR><CR>
map <F8> <Esc>:cwin<CR>
nmap <C-j> o<Esc>k
nmap <C-k> O<Esc>j
cmap <C-k> <Up>
cmap <C-j> <Down>

"Use predefined ctags file for standard libraries. In retrospec not such a
"great idea. Remove?
set tags+=~/.vim/systags
"Don't really need that much history
set history=30
"Use % to switch between open and close structures, #if/#endif etc.
runtime macros/matchit.vim
"Turn on omnicompletion
set omnifunc=syntaxcomplete#Complete
"Because <C-x><C-o> is literally the worst mapping for completion
imap <leader><Tab> <C-x><C-o>

