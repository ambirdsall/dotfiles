.POSIX:
.SUFFIXES:
install: .emacs.d tpm

.emacs.d:
	git clone -b develop https://github.com/syl20bnr/spacemacs.git ~/.emacs.d
	git clone git@github.com:praveenperera/spacemacs-prettier.git ~/.emacs.d/private/spacemacs-prettier

tpm:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
