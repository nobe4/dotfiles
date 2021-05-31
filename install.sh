#!/usr/bin/env zsh
# vim: set foldmarker={,} foldmethod=marker

# Setup {
set -x

# Save the current folder
DOTFILE_FOLDER="$(dirname $(dirname $(readlink ~/.zshrc)))"

# Import utilities
source ./utils.zsh

# }

# ZSH {
# Change to zsh
is_interactive && {
	sudo chsh -s $(which zsh)
}
# }

# Fonts {
curl -L https://github.com/adobe-fonts/source-code-pro/archive/refs/heads/release.zip -o /tmp/source-code-pro.zip
unzip -q /tmp/source-code-pro.zip -d /tmp/

is_macos && mv /tmp/source-code-pro-release/TTF/* /Library/Fonts/
# is_linux && sudo mv /tmp/source-code-pro-release/TTF/* /usr/local/share/fonts/
# }

# Vim {
is_macos && {
	dwld_link="$(curl -L -s https://github.com/macvim-dev/macvim/releases/latest | grep 'MacVim.dmg"' | cut -d '"' -f 2)"
	curl -L -s "https://github.com$dwld_link" -o /tmp/MacVim.dmg
	open /tmp/MacVim.dmg
	wait_until "MacVim is moved to /Application"
}
is_linux && {
	sudo apt-get install -y vim
}

# Add the swapfile and undodir folder
mkdir -p ~/.vim/swapdir/
mkdir -p ~/.vim/undodir/

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall!
# }

# Golang {
is_macos && {
	open https://golang.org/doc/install
	wait_until "golang is installed"
	go get golang.org/x/tools/cmd/goimports
}

# https://github.com/golang/go/wiki/Ubuntu
is_linux && {
	sudo add-apt-repository -y ppa:longsleep/golang-backports &&\
	sudo apt update -y &&\
	sudo apt install -y golang-go
}
# }

# Tmux {
is_macos && {
	brew install tmux
	# https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard
	brew install reattach-to-user-namespace
}

# https://github.com/golang/go/wiki/Ubuntu
is_linux && {
	sudo apt-get install -y tmux
}

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm/" ]; then
	git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi
# }

# Ruby {
is_macos && {
	brew install rbenv
	# TODO understand what this does
	# rbenv init
	# rbenv install
	# rbenv global 2.7.3
	# gem install irb
}
# TODO Add Linux
# }

# Python {
is_macos && {
	# https://docs.brew.sh/Homebrew-and-Python
	brew install python
}

# Nothing to do on linux

python3 -m pip install black
# }

# Kitty {
# Install manually
open https://github.com/kovidgoyal/kitty/releases

wait_until "Kitty is installed"

# Add "include other conf" in default conf file
mkdir -p ~/.config/kitty/
cat << EOF > ~/.config/kitty/kitty.conf
#press gf on here
include $DOTFILE_FOLDER/kitty/kitty.conf
EOF

# }

# Espanso {
is_macos && {
	brew tap federico-terzi/espanso
	brew install espanso
	espanso register
	wait until "espanso is registered"

	espanso start
	espanso install all-emojis
	espanso install french-accents

	ln -fs "$DOTFILE_FOLDER/espanso/espanso_config.yml" "$HOME/Library/Preferences/espanso/default.yml"
}
# }

# Gpg {
is_macos && {
	brew install gnupg gnupg2 pinentry-mac

	mkdir ~/.gnupg
	echo 'pinentry-program $(brew --prefix)/bin/pinentry-mac' > ~/.gnupg/gpg-agent.conf
	echo 'use-agent' > ~/.gnupg/gpg.conf
	chmod 700 ~/.gnupg
}
# }

# Nodejs {
is_macos && {
	brew install node
}

is_linux && {
	curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
	sudo apt-get install -y nodejs
}

npm install --global prettier standard
# }

# OS-Specific {
is_macos {
	# ref: https://github.com/mathiasbynens/dotfiles/blob/master/.osx
	# Default finder view: column
	defaults write com.apple.Finder FXPreferredViewStyle clmv

	# Show the ~/Library folder.
	chflags nohidden ~/Library
}
# }

# Search {
is_macos && {
	brew install ripgrep
	brew install fzf
	$(brew --prefix)/opt/fzf/install --bin --key-bindings
}

is_linux {
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
	brew install trash z shellcheck
	brew install --cask rectangle
	brew install gdb
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
# }
