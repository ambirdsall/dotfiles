# Welcome! On a new computer, start by running `make install`.
# Once that is done, you can follow with any relevant system-dependent setup tasks
# (like `make x11` or `make macos`) as needed.

# Because `make install` sets up doom emacs, any downstream tasks can use
# ~/.emacs.d/bin/org-tangle to manage literate configurations.

.POSIX:
.SUFFIXES:
.PHONY: x11

install: .emacs.d tpm

.emacs.d:
	git clone git@github.com:hlissner/doom-emacs.git ~/.emacs.d
	~/.emacs.d/bin/doom install

tpm:
	git clone git@github.com:tmux-plugins/tpm ~/.tmux/plugins/tpm

x11:
	systemctl --user enable xmodmap xcape
	systemctl --user start xmodmap xcape
