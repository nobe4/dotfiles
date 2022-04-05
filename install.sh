#!/usr/bin/env zsh
# vim: foldmarker={,} foldmethod=marker

set -ex

# This script installs all requirements.

# Setup {
export DOTFILE_FOLDER="$HOME/.dot"
source "$DOTFILE_FOLDER/utils.zsh"
# }

# ZSH {
# Change to zsh
is_interactive && {
	sudo chsh -s $(which zsh)
}

link "$DOTFILE_FOLDER/.zshrc" "$HOME/.zshrc"
link "$DOTFILE_FOLDER/.zprofile" "$HOME/.zprofile"
link "$DOTFILE_FOLDER/.zshenv" "$HOME/.zshenv"
link "$DOTFILE_FOLDER/.bashrc" "$HOME/.bashrc"
# }

# Fonts {
curl -L https://github.com/adobe-fonts/source-code-pro/archive/refs/heads/release.zip -o /tmp/source-code-pro.zip
unzip -q /tmp/source-code-pro.zip -d /tmp/

is_macos && mv /tmp/source-code-pro-release/TTF/* /Library/Fonts/
# TODO
# is_linux && sudo mv /tmp/source-code-pro-release/TTF/* /usr/local/share/fonts/
rm -rf /tmp/source-code-pro-release
# }

# Homebrew {
is_macos && {
	open "https://brew.sh/"
	wait_until "Homebrew is installed"
	brew bundle install
	BREW_PREFIX=$(brew --prefix)
}
# }

# Vim {
is_linux && {
	sudo apt-get install -y vim
}

link "$DOTFILE_FOLDER/.vimrc" "$HOME/.vimrc"
link "$DOTFILE_FOLDER/.vim" "$HOME/.vim"

# Install vim-plug
curl -fLo "$DOTFILE_FOLDER/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall!
# }

# Git {
link "$DOTFILE_FOLDER/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILE_FOLDER/.gitignore_global" "$HOME/.gitignore_global"
# }

# Golang {
is_macos && {
	open https://golang.org/doc/install
	wait_until "golang is installed"
	go install golang.org/x/tools/cmd/goimports
}
is_linux && {
	# https://github.com/golang/go/wiki/Ubuntu
	sudo add-apt-repository -y ppa:longsleep/golang-backports &&\
		sudo apt update -y &&\
		sudo apt install -y golang-go
	}
# }

# Tmux {
is_linux && {
	# https://github.com/golang/go/wiki/Ubuntu
	sudo apt-get install -y tmux
}

link "$DOTFILE_FOLDER/.tmux.conf" "$HOME/.tmux.conf"

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm/" ]; then
	git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
# }

# Ruby {
is_macos && {
	# Configure ruby with rbenv
	ruby_latest="$(rbenv install -l | grep -v - | tail -1)"
	rbenv install --skip-existing "$ruby_latest"
	rbenv global "$ruby_latest"
}

# TODO Add Linux

# Install some packages
gem install irb rubocop

link "$DOTFILE_FOLDER/.pryrc" "$HOME/.pryrc"
# }

# Python {
is_linux && {
	sudo apt-get update && sudo apt-get upgrade
	sudo apt-get install python3.9
}
# Nothing to do on linux

python3 -m pip install black
link "$DOTFILE_FOLDER/.pdbrc" "$HOME/.pdbrc"
# }

# Kitty {
# Add "include other conf" in default conf file
is_macos && {
	open 'https://github.com/kovidgoyal/kitty/releases/latest'
	wait_until 'kitty is installed'
	mkdir -p "$HOME/.config/kitty/"
	cat << EOF > ~/.config/kitty/kitty.conf
	#press gf on here
	include $DOTFILE_FOLDER/kitty.conf
EOF
}
# }

# Espanso {
is_macos && {
	espanso register || true
	wait_until "espanso is registered"

	espanso start || true
	espanso install all-emojis

	# We're going to use the local espanso config so we can track its changes.
	ln -fs "$DOTFILE_FOLDER/espanso_config.yml" "$HOME/Library/Preferences/espanso/default.yml"
	ln -fs "$DOTFILE_FOLDER/private/espanso_config.yml" "$HOME/Library/Preferences/espanso/user/private.yml"
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

# Nodejs {
is_linux && {
	curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
	sudo apt-get install -y nodejs
}

npm install --global prettier standard
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

# Search {
is_macos && {
	"$BREW_PREFIX/opt/fzf/install" --bin --key-bindings
}

is_linux && {
	# Ripgrep
	curl -L https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb -o ./search/ripgrep.deb
	sudo dpkg -i ./search/ripgrep.deb
	rm ./search/ripgrep.deb

	# Fzf
	# ref: https://github.com/junegunn/fzf#using-git
	git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/fzf
	/tmp/fzf/install --bin --key-bindings
}
# }

# Misc {
is_macos && {
	link "$DOTFILE_FOLDER/.gdbinit" "$HOME/.gdbinit"
	# Don't wait for that
	open https://sourceware.org/gdb/wiki/BuildingOnDarwin
}
is_linux && {
	# TODO redo this
	# curl https://raw.githubusercontent.com/rupa/z/master/z.sh -o ./misc/z.sh
	# curl https://raw.githubusercontent.com/PhrozenByte/rmtrash/master/rmtrash -o ./misc/trash.bin
	# chmod +x ./misc/trash.bin
	# sudo apt install -y shellcheck
}

touch "$HOME/.z"

link "$DOTFILE_FOLDER/.lynx.cfg" "$HOME/.lynx.cfg"
link "$DOTFILE_FOLDER/.lynx.lss" "$HOME/.lynx.lss"
link "$DOTFILE_FOLDER/.muttrc" "$HOME/.muttrc"
link "$DOTFILE_FOLDER/.vale.ini" "$HOME/.vale.ini"

(git clone git@github.com:errata-ai/Google.git /tmp/vale-tmp-google && mv /tmp/vale-tmp-google/Google $DOTFILE_FOLDER/vale-styles) &
(git clone git@github.com:errata-ai/proselint.git /tmp/vale-tmp-prose && mv /tmp/vale-tmp-prose/proselint $DOTFILE_FOLDER/vale-styles) &
(git clone git@github.com:testthedocs/Openly.git /tmp/vale-tmp-openly && mv /tmp/vale-tmp-openly/Openly $DOTFILE_FOLDER/vale-styles) &

tldr --update
# }
# Private {
./private/install.sh
# }
