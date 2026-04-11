#!/usr/bin/env bash

set -e

# SEE https://github.com/neovim/nvim-lspconfig/tree/master/lsp

for file in "${DOTFILE_FOLDER}/nvim/lsp"/*.lua; do
	name=$(basename "${file}")
	echo "Updating ${name}..."
	gh api \
		-H "Accept: application/vnd.github.raw+text" \
		"/repos/neovim/nvim-lspconfig/contents/lsp/${name}" \
	> "${file}"
done
