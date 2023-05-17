-- Test current package and possibly current function
local function find_parent_test_function_name()
	local current_node = vim.treesitter.get_node()

	while current_node do
		if
			(current_node:type() == "function_definition" or current_node:type() == "function_declaration")
			and ((vim.treesitter.get_node_text(current_node, 0)):find("^func Test") ~= nil)
		then
			break
		end
		current_node = current_node:parent()
	end

	if not current_node then
		return ""
	end

	return vim.treesitter.get_node_text(current_node:child(1), 0)
end

vim.keymap.set("n", "<leader>m", function()
	local cmd = ":execute 'split term://go test -race -cover ./%:h"
	local parent = find_parent_test_function_name()
	if parent ~= "" then
		cmd = cmd .. " -run " .. parent
	end
	cmd = cmd .. "'"
	vim.cmd(cmd)
end, { noremap = true, silent = false })
