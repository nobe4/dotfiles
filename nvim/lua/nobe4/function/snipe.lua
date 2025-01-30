local setTimeout = require("nobe4/function/settimeout")

local bak = {
	colorcolumn = vim.opt.colorcolumn,
	cursorline = vim.opt.cursorline,
	cursorline_hl = vim.api.nvim_get_hl(0, { name = "CursorLine" }),
	colorcolumn_hl = vim.api.nvim_get_hl(0, { name = "ColorColumn" }),
}

return function()
	setTimeout(200, vim.schedule_wrap(function()
		vim.opt.colorcolumn = bak.colorcolumn
		vim.opt.cursorline = bak.cursorline
		vim.api.nvim_set_hl(0, "CursorLine", bak.cursorline_hl)
		vim.api.nvim_set_hl(0, "ColorColumn", bak.colorcolumn_hl)
	end))

	vim.opt.colorcolumn = tostring(vim.fn.virtcol("."))
	vim.opt.cursorline = true
	vim.api.nvim_set_hl(0, "CursorLine", { reverse = true })
	vim.api.nvim_set_hl(0, "ColorColumn", { reverse = true })
end
