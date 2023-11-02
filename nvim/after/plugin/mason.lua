local mason = require("mason")
local registry = require("mason-registry")
local lsp_config = require("mason-lspconfig")

mason.setup({
	ui = {
		border = "single",
	},
})

local ensured_installed_packages = {
	"clang-format",
	"clangd",

	"goimports",
	"golangci-lint",
	"gopls",

	"marksman",
	"vale",

	"prettier",

	"solargraph",

	"selene",
	"stylua",

	"css-lsp",
	"html-lsp",
	"json-lsp",
	"emmet-ls",

	"shellcheck",
	"bash-language-server",

	"black",

	"yaml-language-server",
	"yamlfmt",
	"yamllint",
}

for _, package in ipairs(ensured_installed_packages) do
	local p = registry.get_package(package)

	if not p:is_installed() then
		p:install()
	end
end

lsp_config.setup()
