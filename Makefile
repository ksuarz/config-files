# Makefile - for quick installation of configuration files

LNFLAGS = -fsn
RMFLAGS = -f

all: install

# Installs files by making the appropriate symbolic links
install:
	ln $(LNFLAGS) $(PWD)/X/Xresources $(HOME)/.Xresources
	ln $(LNFLAGS) $(PWD)/X/xinitrc $(HOME)/.xinitrc
	ln $(LNFLAGS) $(PWD)/bash/bash_aliases $(HOME)/.bash_aliases
	ln $(LNFLAGS) $(PWD)/bash/bash_profile $(HOME)/.bash_profile
	ln $(LNFLAGS) $(PWD)/bash/bash_prompt $(HOME)/.bash_prompt
	ln $(LNFLAGS) $(PWD)/bash/bashrc $(HOME)/.bashrc
	ln $(LNFLAGS) $(PWD)/gitconfig $(HOME)/.gitconfig
	ln $(LNFLAGS) $(PWD)/tmux.conf $(HOME)/.tmux.conf
	ln $(LNFLAGS) $(PWD)/vim/ $(HOME)/.vim
	ln $(LNFLAGS) $(PWD)/vim/gvimrc $(HOME)/.gvimrc
	ln $(LNFLAGS) $(PWD)/vim/vimrc $(HOME)/.vimrc

# Installs OpenBox settings
openbox:
	cp -f $(PWD)/openbox/rc.xml $(HOME)/.config/openbox/rc.xml
	cp -f $(PWD)/openbox/autostart $(HOME)/.config/openbox/autostart

# Change up how Conky looks on-the-fly
conky-clock:
	rm $(RMFLAGS) $(HOME)/.conkyrc
	ln $(LNFLAGS) $(PWD)/conky/conkyrc.clock $(HOME)/.conkyrc

conky-system:
	rm $(RMFLAGS) $(HOME)/.conkyrc
	ln $(LNFLAGS) $(PWD)/conky/conkyrc.system $(HOME)/.conkyrc

conky-blank:
	rm $(RMFLAGS) $(HOME)/.conkyrc
	ln $(LNFLAGS) $(PWD)/conky/conkyrc.blank $(HOME)/.conkyrc

conky-goaway: conky-blank

# Remove all traces of configuration files
clean:
	rm $(RMFLAGS) $(HOME)/.Xresources
	rm $(RMFLAGS) $(HOME)/.bash_aliases
	rm $(RMFLAGS) $(HOME)/.bash_profile
	rm $(RMFLAGS) $(HOME)/.bash_prompt
	rm $(RMFLAGS) $(HOME)/.bashrc
	rm $(RMFLAGS) $(HOME)/.gitconfig
	rm $(RMFLAGS) $(HOME)/.gvimrc
	rm $(RMFLAGS) $(HOME)/.tmux.conf
	rm $(RMFLAGS) $(HOME)/.vim
	rm $(RMFLAGS) $(HOME)/.vimrc
	rm $(RMFLAGS) $(HOME)/.xinitrc

# Remove non-standard configuration files
mostlyclean:
	rm $(RMFLAGS) $(HOME)/.bash_prompt
	rm $(RMFLAGS) $(HOME)/.gitconfig
	rm $(RMFLAGS) $(HOME)/.gvimrc
	rm $(RMFLAGS) $(HOME)/.vim
