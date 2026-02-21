-- https://github.com/Shopify/ruby-lsp/blob/main/EDITORS.md#neovim-lsp
return {
	cmd = { 'bundle', 'exec', 'ruby-lsp' },
	filetypes = { 'ruby', 'eruby' },
	root_markers = { 'Gemfile', '.git' },
	init_options = {
		formatter = 'auto',
	},
	settings = {
		formatter = "rubocop",
		linters = { "rubocop" },
		enabledFeatures = {
			codeActions = true,
			codeLens = true,
			completion = true,
			definition = true,
			diagnostics = true,
			documentHighlights = true,
			documentLink = true,
			documentSymbols = true,
			foldingRanges = true,
			formatting = true,
			hover = true,
			inlayHint = true,
			onTypeFormatting = true,
			selectionRanges = true,
			semanticHighlighting = true,
			signatureHelp = true,
			typeHierarchy = true,
			workspaceSymbol = true,
		},
		featuresConfiguration = {
			inlayHint = {
				implicitHashValue = true,
				implicitRescue = true,
			},
		},
	},
	reuse_client = function(client, config)
		config.cmd_cwd = config.root_dir
		return client.config.cmd_cwd == config.cmd_cwd
	end,
}
