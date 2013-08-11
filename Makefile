# Makefile - for quick installation of configuration files

LNFLAGS = -fsn
RMFLAGS = -f

all: install

install:
	ln $(LNFLAGS) $(PWD)/bash_aliases $(HOME)/.bash_aliases
	ln $(LNFLAGS) $(PWD)/bash_profile $(HOME)/.bash_profile
	ln $(LNFLAGS) $(PWD)/bash_prompt $(HOME)/.bash_prompt
	ln $(LNFLAGS) $(PWD)/bashrc $(HOME)/.bashrc
	ln $(LNFLAGS) $(PWD)/gitconfig $(HOME)/.gitconfig
	ln $(LNFLAGS) $(PWD)/gvimrc $(HOME)/.gvimrc
	ln $(LNFLAGS) $(PWD)/tmux.conf $(HOME)/.tmux.conf
	ln $(LNFLAGS) $(PWD)/vimrc $(HOME)/.vimrc
	ln $(LNFLAGS) $(PWD)/vim/ $(HOME)/.vim
	ln $(LNFLAGS) $(PWD)/Xdefaults $(HOME)/.Xdefaults

clean:
	rm $(RMFLAGS) .*.swp
	rm $(RMFLAGS) *~
