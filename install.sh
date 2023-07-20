#!/usr/bin/env zsh
# vim: foldmarker={,} foldmethod=marker

set -e

# This script installs all requirements.

# Setup {
export DOTFILE_FOLDER="$HOME/.dot"
source "$DOTFILE_FOLDER/utils.zsh"
# }

# ZSH {
# Change to zsh
is_interactive && {
	if [[ "$SHELL" != "$(which zsh)" ]]; then
		sudo chsh -s $(which zsh)
	fi
}

link "$DOTFILE_FOLDER/.zshrc" "$HOME/.zshrc"
link "$DOTFILE_FOLDER/.zprofile" "$HOME/.zprofile"
link "$DOTFILE_FOLDER/.zshenv" "$HOME/.zshenv"
link "$DOTFILE_FOLDER/.bashrc" "$HOME/.bashrc"
mkdir -p "$HOME/.local/bin"
# }

# Fonts {
unzip -q ./CommitMono.zip -d /tmp/commitmono/

is_macos && mv /tmp/commitmono/*.otf /Library/Fonts/
is_linux && {
	mkdir -p ~/.local/share/fonts
	mv /tmp/commitmono/*.otf ~/.local/share/fonts/
}

rm -rf /tmp/commitmono/
# }

# Homebrew {
if ! command -v brew &> /dev/null; then
	open "https://brew.sh/"
	wait_until "Homebrew is installed"
fi

brew bundle install
BREW_PREFIX=$(brew --prefix)
# }

# Linux base packages {
is_linux &&  {
	sudo apt-get update
	sudo apt-get install autoconf patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
}
# }

# Neovim {
link "$DOTFILE_FOLDER/nvim/" "$HOME/.config/nvim"
# }

# Git {
link "$DOTFILE_FOLDER/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILE_FOLDER/.gitignore_global" "$HOME/.gitignore_global"
# }

# Tmux {
mkdir -p "$HOME/.config/tmux"
link "$DOTFILE_FOLDER/tmux.conf" "$HOME/.config/tmux/tmux.conf"
# }

# Install tmux plugin manager
if [ ! -d "$HOME/.config/tmux/plugins/tpm/" ]; then
	git clone https://github.com/tmux-plugins/tpm "$HOME/.config/tmux/plugins/tpm"
fi
# }

# Ruby {
# Configure ruby with rbenv
ruby_latest="$(rbenv install -l | grep -v - | tail -1)"
rbenv install --skip-existing "$ruby_latest"
rbenv global "$ruby_latest"

link "$DOTFILE_FOLDER/.rubocop.yml" "$HOME/.rubocop.yml"
link "$DOTFILE_FOLDER/.pryrc" "$HOME/.pryrc"
# }

# Kitty {
mkdir -p "$HOME/.config/kitty/"
link "$DOTFILE_FOLDER/kitty.conf" "$HOME/.config/kitty/kitty.conf"
# }

# 1password cli {
is_linux && {
	curl -o op.deb https://downloads.1password.com/linux/debian/amd64/stable/1password-cli-amd64-latest.deb
	sudo dpkg --skip-same-version -i op.deb
	rm op.deb
}
# }

# Espanso {
is_linux && {
	if ! command -v espanso &> /dev/null; then
		open "https://espanso.org/docs/install/linux/#install-on-x11"
		wait_until "espanso is installed"
	end
}
espanso service register || true
espanso start || true

# We're going to use the local espanso config so we can track its changes.
is_macos && {
	link "$DOTFILE_FOLDER/espanso_config.yml" "$HOME/Library/Preferences/espanso/default.yml"
	link "$DOTFILE_FOLDER/private/espanso_config.yml" "$HOME/Library/Preferences/espanso/user/private.yml"
}
# }

# GPG {
is_macos && {
	mkdir -p "$HOME/.gnupg"
	echo "pinentry-program $BREW_PREFIX/bin/pinentry-mac" > "$HOME/.gnupg/gpg-agent.conf"
	echo 'use-agent' > "$HOME/.gnupg/gpg.conf"
	chmod 700 "$HOME/.gnupg"
}
# }

# OS-Specific {
is_macos && {
	# ref: https://github.com/mathiasbynens/dotfiles/blob/master/.osx
	# Default finder view: column
	defaults write com.apple.Finder FXPreferredViewStyle clmv

	# Show the $HOME/Library folder.
	chflags nohidden "$HOME/Library"
}
# }

# misc {
"$BREW_PREFIX/opt/fzf/install" --bin --key-bindings

touch "$HOME/.z"
tldr --update

link "$DOTFILE_FOLDER/.vale.ini" "$HOME/.vale.ini"

mkdir -p "$HOME/.config/gh"
link "$DOTFILE_FOLDER/gh-config.yml" "$HOME/.config/gh/config.yml"
# }

# Private {
./private/install.sh
# }
