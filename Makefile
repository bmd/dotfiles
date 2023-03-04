export ZSH_CUSTOM

default: help

install: bootstrap bundle symlinks

bundle:
	brew bundle install -v

install-homebrew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	(echo; echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"') >> $(HOME)/.zprofile
	eval "$$(/opt/homebrew/bin/brew shellenv)"

install-oh-my-zsh:
	sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

install-spaceship:
	git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$(HOME)/.oh-my-zsh/custom/themes/spaceship-prompt" --depth=1 && \
		ln -s "$(HOME)/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$(HOME)/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

bootstrap: install-homebrew install-spaceship


uninstall: remove-symlinks remove-spaceship


% :: dotfiles/%
	ln -sfv $(shell pwd)/$< $(HOME)

symlinks: \
	.aliases.zsh \
	.aws.zsh \
	.editorconfig \
	.gcloud.zsh \
	.gitconfig \
	.gitignore_global \
	.helpers.zsh \
	.path.zsh \
	.spaceship.zsh \
	.zshrc

remove-homebrew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

remove-symlinks:
	rm -f $(HOME)/.aliases.zsh \
		$(HOME)/.aws.zsh \
		$(HOME)/.editorconfig \
		$(HOME)/.gcloud.zsh \
		$(HOME)/.gitconfig \
		$(HOME)/.gitignore_global \
		$(HOME)/.helpers.zsh \
		$(HOME)/.logrocket.zsh \
		$(HOME)/.path.zsh \
		$(HOME)/.spaceship.zsh \
		$(HOME)/.zshrc

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
