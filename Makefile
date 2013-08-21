# Makefile - for quick installation of configuration files

LNFLAGS = -fsn
RMFLAGS = -f

all: install

# Installs files by making the appropriate symbolic links
install:
	ln $(LNFLAGS) $(PWD)/bash/bash_aliases $(HOME)/.bash_aliases
	ln $(LNFLAGS) $(PWD)/bash/bash_profile $(HOME)/.bash_profile
	ln $(LNFLAGS) $(PWD)/bash/bash_prompt $(HOME)/.bash_prompt
	ln $(LNFLAGS) $(PWD)/bash/bashrc $(HOME)/.bashrc
	ln $(LNFLAGS) $(PWD)/gitconfig $(HOME)/.gitconfig
	ln $(LNFLAGS) $(PWD)/vim/gvimrc $(HOME)/.gvimrc
	ln $(LNFLAGS) $(PWD)/tmux.conf $(HOME)/.tmux.conf
	ln $(LNFLAGS) $(PWD)/vim/vimrc $(HOME)/.vimrc
	ln $(LNFLAGS) $(PWD)/vim/ $(HOME)/.vim
	ln $(LNFLAGS) $(PWD)/Xdefaults $(HOME)/.Xdefaults

# Change tint2 color settings
tint-blue:
	rm $(RMFLAGS) $(HOME)/.config/tint2/tint2rc
	ln $(LNFLAGS) $(PWD)/tint2/tint2rc.blue $(HOME)/.config/tint2/tint2rc

tint-green:
	rm $(RMFLAGS) $(HOME)/.config/tint2/tint2rc
	ln $(LNFLAGS) $(PWD)/tint2/tint2rc.green $(HOME)/.config/tint2/tint2rc

tint-grey:
	rm $(RMFLAGS) $(HOME)/.config/tint2/tint2rc
	ln $(LNFLAGS) $(PWD)/tint2/tint2rc.grey $(HOME)/.config/tint2/tint2rc

tint-magenta:
	rm $(RMFLAGS) $(HOME)/.config/tint2/tint2rc
	ln $(LNFLAGS) $(PWD)/tint2/tint2rc.magenta $(HOME)/.config/tint2/tint2rc

tint-red:
	rm $(RMFLAGS) $(HOME)/.config/tint2/tint2rc
	ln $(LNFLAGS) $(PWD)/tint2/tint2rc.red $(HOME)/.config/tint2/tint2rc

tint-yellow:
	rm $(RMFLAGS) $(HOME)/.config/tint2/tint2rc
	ln $(LNFLAGS) $(PWD)/tint2/tint2rc.yellow $(HOME)/.config/tint2/tint2rc

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

# Clean up swap files in the working directory
clean-swap:
	rm $(RMFLAGS) .*.swp
	rm $(RMFLAGS) *~

# Remove all traces of configuration files
clean:
	rm $(RMFLAGS) $(HOME)/.bash_aliases
	rm $(RMFLAGS) $(HOME)/.bash_profile
	rm $(RMFLAGS) $(HOME)/.bash_prompt
	rm $(RMFLAGS) $(HOME)/.bashrc
	rm $(RMFLAGS) $(HOME)/.gitconfig
	rm $(RMFLAGS) $(HOME)/.gvimrc
	rm $(RMFLAGS) $(HOME)/.tmux.conf
	rm $(RMFLAGS) $(HOME)/.vimrc
	rm $(RMFLAGS) $(HOME)/.vim
	rm $(RMFLAGS) $(HOME)/.Xdefaults
	rm $(RMFLAGS) $(HOME)/.config/tint2/tint2rc

# Remove non-standard configuration files
mostlyclean:
	rm $(RMFLAGS) $(HOME)/.bash_prompt
	rm $(RMFLAGS) $(HOME)/.gitconfig
	rm $(RMFLAGS) $(HOME)/.gvimrc
	rm $(RMFLAGS) $(HOME)/.vim
	rm $(RMFLAGS) $(HOME)/.config/tint2/tint2rc
