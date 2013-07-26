all: install

install:
	ln -fs $(PWD)/bashrc $(HOME)/.bashrc
	ln -fs $(PWD)/bash_prompt $(HOME)/.bash_prompt
	ln -fs $(PWD)/bash_aliases $(HOME)/.bash_aliases
	ln -fs $(PWD)/gitconfig $(HOME)/.gitconfig
	ln -fs $(PWD)/gvimrc $(HOME)/.gvimrc
	ln -fs $(PWD)/tmux.conf $(HOME)/.tmux.conf
	ln -fsn $(PWD)/vim/ $(HOME)/.vim
	ln -fs $(PWD)/vimrc $(HOME)/.vimrc
