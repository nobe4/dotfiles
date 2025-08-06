# ZSH {
# Change to zsh
# is_interactive && {
# 	if [[ "$SHELL" != "$(which zsh)" ]]; then
# 		sudo chsh -s $(which zsh)
# 	fi
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
