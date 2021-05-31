#!/usr/bin/env zsh
# vim: foldmarker={,} foldmethod=marker

# This script installs all requirements.

# Setup {
set -ex
source ./utils.zsh
# }

# ZSH {
# Change to zsh
is_interactive && {
	sudo chsh -s $(which zsh)
}

link "$DOTFILE_FOLDER/.zshrc" "$HOME/.zshrc"
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
	brew bundle
	BREW_PREFIX=$(brew --prefix)
}
# }

# Vim {
is_linux && {
	sudo apt-get install -y vim
}

link "$DOTFILE_FOLDER/.vimrc" "$HOME/.vimrc"

# Add the swapfile and undodir folder
mkdir -p "$HOME/.vim/swapdir/"
mkdir -p "$HOME/.vim/undodir/"

# Install vim-plug
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
	go get golang.org/x/tools/cmd/goimports
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
	# TODO understand what this does
	# rbenv init
	# rbenv install
	# rbenv global 2.7.3
	# gem install irb
}
# TODO Add Linux
# }

# Python {
# Nothing to do on linux

python3 -m pip install black
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
	espanso install french-accents

	# TODO
	ln -fs "$DOTFILE_FOLDER/espanso_config.yml" "$HOME/Library/Preferences/espanso/default.yml"
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
# }
