default: help

install: bootstrap symlinks

bootstrap: ## Bootstrap on a fresh machine
	echo 'make bootstrap'
	#chmod +x bootstrap.sh
	#./bootstrap.sh

% :: dotfiles/%
	ln -sfv $(shell pwd)/$< $(HOME)

symlinks: .zshrc .aliases.zsh .aws.zsh .helpers.zsh .path.zsh .spaceship.zsh .1password.zsh

help: ## Show this help dialog
	@echo "\n  Commands:\n"
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//' -e 's/://'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "    %-30s %s\n" $$help_command $$help_info ; \
	done
