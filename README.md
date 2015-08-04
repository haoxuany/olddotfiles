# My dotfiles
Is no longer maintained. Migrated all vim settings to new repository for easier and more consistent management. Most of the settings are probably broken.
## Files
So far it includes:  
+ tmux configuration files for xterm in bash (tested under kubuntu terminal, usually works fine)  
+ vim configuration (modified to suit tmux and xterm, might not be compatible, to be fixed)  

## Installation
Simply clone with:  

	git clone https://github.com/haoxuany/Dotfiles.git

And install plugins listed below, some of the plugins require more than one installation step.  

## Plugins Installed
### Required(if not always present and highly recommended):  
+ Pathogen: https://github.com/tpope/vim-pathogen.git  

Super lazy install(copy paste):

	mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

Remember to generate helptags after everything is done. (Not explicitly generated in .vimrc for performance reasons)  

+ Command-T: https://github.com/wincent/Command-T.git  

However, there's a catch: only systems with vim compiled with ruby support 
and have the same version of ruby installed will work.  

To check:  

	vim --version | grep +ruby #Should return a line containing "+ruby"
	vim --version | grep -oe "ruby-[0-9.]*" #Grep for ruby version used to compile vim
	ruby --version #System ruby version

C compiler also required, but seriously which systems nowadays doesn't have gcc? :D  

+ Selecta: https://github.com/garybernhardt/selecta.git
(Only install if Command-T requirements not satisfied, vimrc settings not added yet)  

Make dir to user bin (if not already present):  

	mkdir ~/bin

And add new path to $PATH.  

### Highly recommended:
+ unimpaired.vim: https://github.com/tpope/vim-unimpaired.git  
+ vim-kolor: https://github.com/zeis/vim-kolor.git  
+ surround.vim: https://github.com/tpope/vim-surround.git  
+ commentary.vim: https://github.com/tpope/vim-commentary.git  

### Optional but nice to have:
+ vim-perv-startify: https://github.com/haoxuany/vim-perv-startify.git (Perverted by me :D)  
+ vim-startify: https://github.com/mhinz/vim-startify.git (Deprecated, use perv-startify)  

## Todos
+ Reformat vimrc for better performance and readability  
+ Add optional code for portability using selecta  
+ Write script for instant modification  
+ Add plugins as submodules (?)  
