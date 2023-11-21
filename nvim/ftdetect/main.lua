local mappings = {
	sh = { "*.zsh", "*.bash" },
	graphql = { "*.graphql" },
	jsp = { "*.jspf" },
	markdown = { "*.md" },
	yaml = { "*.sls" },
	ruby = { "*.ru", "Vagrantfile", "Brewfile" },
	javascript = { "*.coffee", "*.gs" },
	json = { "*.tfstate" },
	terraform = { "*.tfvars" },
	svelte = { "*.svelte" },
	vuejs = { "*.vue" },
	scss = { "*.scss" },
}

for ft, patterns in pairs(mappings) do
	for _, pattern in pairs(patterns) do
		vim.cmd("autocmd BufNewFile,BufRead " .. pattern .. " set filetype=" .. ft)
	end
end
