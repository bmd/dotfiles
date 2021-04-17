default: help

install: bootstrap bundle symlinks

bundle:
	brew bundle install -v

bootstrap: ## Bootstrap on a fresh machine
	# Install homebrew and deps
	echo | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# Install oh-my-zsh
	curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh

% :: dotfiles/%
	ln -sfv $(shell pwd)/$< $(HOME)

symlinks: .gitconfig .gitignore_global .editorconfig .zshrc \
	.aliases.zsh .aws.zsh .helpers.zsh .path.zsh .spaceship.zsh \
	.1password.zsh .jetbrains.zsh .gcloud.zsh

update:
	git pull
	$(MAKE) symlinks

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
