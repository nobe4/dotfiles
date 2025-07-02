# ZSH {
# Change to zsh
# is_interactive && {
# 	if [[ "$SHELL" != "$(which zsh)" ]]; then
# 		sudo chsh -s $(which zsh)
# 	fi
# }

# Fonts {
# https://github.com/eigilnikolajsen/commit-mono/issues/15#issuecomment-1948102784
unzip -q ./CommitMono.zip -d /tmp/commitmono/
# install https://github.com/ryanoasis/nerd-fonts/releases

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


# OS-Specific {
is_macos && {
	# ref: https://github.com/mathiasbynens/dotfiles/blob/master/.osx
	# Default finder view: column
	defaults write com.apple.Finder FXPreferredViewStyle clmv

    # Show all files
    defaults write com.apple.Finder AppleShowAllFiles true

	# Show the $HOME/Library folder.
	chflags nohidden "$HOME/Library"
}
# }

# misc {
"$BREW_PREFIX/opt/fzf/install" --bin --key-bindings

# Espanso {
if ! command -v espanso &> /dev/null; then
	open "https://espanso.org/docs/install/linux/#install-on-x11"
	wait_until "espanso is installed"
fi
# It's possible that this fails between installs, in which case forcing a clean
# reinstall seems to have solved the issue.
# brew uninstall espanso
# trash $HOME/Library/Application\ Support/espanso
espanso service register || true
espanso start

tldr --update
