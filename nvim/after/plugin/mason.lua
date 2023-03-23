local mason = require("mason")
local registry = require("mason-registry")
local lsp_config = require("mason-lspconfig")

mason.setup({
	ui = {
		border = "single",
	},
})

local ensured_installed_packages = {
	"golangci-lint",
	"clang-format",
	"vale",
	"stylua",
	"selene",
	"clangd",
	"goimports",
	"gopls",
	"prettier",
	"solargraph",
}

for _, package in ipairs(ensured_installed_packages) do
	local p = registry.get_package(package)

	if not p:is_installed() then
		p:install()
	end
end

lsp_config.setup()
