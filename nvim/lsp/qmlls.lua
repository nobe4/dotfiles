---@brief
---
--- https://doc.qt.io/qt-6/qtqml-tooling-qmlls.html
---
--- > QML Language Server is a tool shipped with Qt that helps you write code in your favorite (LSP-supporting) editor.
---
--- Source in the [QtDeclarative repository](https://code.qt.io/cgit/qt/qtdeclarative.git/)
---
--- Note: On some distros, the cmd of qmlls is `qmlls6`. You can override `cmd`:
--- ```lua
--- vim.lsp.config('qmlls', { cmd = { 'qmlls6' } })
--- ```

---@type vim.lsp.Config
return {
	cmd = { "qmlls", "-v", "-l", "/tmp/qmlls.log" },
	filetypes = { "qml", "qmljs" },
	root_markers = { ".git" },
	handlers = {
		-- While writing quickshell QML, filter noisy warnings.
		["textDocument/publishDiagnostics"] = function(_, result, ctx, _)
			if result.diagnostics then
				local patterns = {
					"Expected only type",
					"Warnings occurred while importing module",
					"Type PanelWindow is not creatable",
				}
				result.diagnostics = vim.tbl_filter(
					function(diag)
						for _, pattern in ipairs(patterns) do
							if diag.message:match(pattern) then
								return false
							end
						end
						return true
					end,
					result.diagnostics
				)
			end
			vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx)
		end,
	},
}
