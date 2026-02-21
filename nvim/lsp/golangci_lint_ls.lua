return {
	cmd = { "golangci-lint-langserver" },
	filetypes = { "go", "gomod" },
	init_options = {
		-- command = { "go", "tool", "golangci-lint", "run", "--output.json.path=stdout", "--show-stats=false" },
		command = { "golangci-lint", "run", "--output.json.path=stdout", "--show-stats=false" },
	},
}
