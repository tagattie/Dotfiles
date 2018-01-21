CANDIDATES :=	$(wildcard .??*)
EXCLUDES :=	.emacs.d .git .gitignore
DOTFILES :=	$(filter-out $(EXCLUDES), $(CANDIDATES))
EMACSINITFILES :=	.emacs.d/Cask .emacs.d/init.el

.PHONY: install-dotfiles
install-dotfiles:
	@$(foreach target, $(DOTFILES), ln -sfv $(abspath $(target)) $(HOME)/$(target);)
	mkdir -p $(HOME)/.emacs.d
	@$(foreach target, $(EMACSINITFILES), ln -sfv $(abspath $(target)) $(HOME)/$(target);)

.PHONY: install-emacs
install-emacs:
	$(shell pwd)/install-emacs.sh

.PHONY: install-zsh
install-zsh:
	$(shell pwd)/install-zsh.sh
