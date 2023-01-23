local command = vim.api.nvim_create_user_command
local opts = { bang = true }

-- Source and edit vimrc file
command("SourceVimrc", "silent source $MYVIMRC", opts)
command("VimrcSource", "silent source $MYVIMRC", opts)
command("EditVimrc", "edit $MYVIMRC", opts)
command("VimrcEdit", "edit $MYVIMRC", opts)

local sudo_write_cmd = "write !sudo tee % >/dev/null"
command("SudoWrite", sudo_write_cmd, opts)
command("WriteSudo", sudo_write_cmd, opts)

command("JSONPretty", "%!jq '.'", opts)
command("Writing", "setlocal wrap linebreak spell spellcapcheck= filetype=markdown", opts)

command("Format", function()
	vim.lsp.buf.formatting()
end, opts)
command("ColorGroup", function()
	vim.cmd([[
		let s = synID(line('.'), col('.'), 1) | echo synIDattr(s, 'name') . ' -> ' . synIDattr(synIDtrans(s), 'name')
	]])
	print(require("nvim-treesitter.ts_utils").get_node_at_cursor())
end, opts)

command("Glow", function()
	local glow_augroup = vim.api.nvim_create_augroup("Glow", { clear = true })
	local glow_augroup_preview = vim.api.nvim_create_augroup("GlowPreview", { clear = true })

	local markdown_win = vim.api.nvim_get_current_win()
	local markdown_buf = vim.api.nvim_get_current_buf()
	local markdown_file = vim.api.nvim_buf_get_name(markdown_buf)

	-- Create a new split and get the window
	vim.cmd("vsplit")
	local preview_win = vim.api.nvim_get_current_win()

	-- Switch to preview window, refresh content and go back
	local preview = function()
		vim.api.nvim_set_current_win(preview_win)

		-- Save the cursor position
		local cursor = vim.api.nvim_win_get_cursor(preview_win)

		vim.api.nvim_cmd({ cmd = "term", args = { "glow", markdown_file } }, {})

		local preview_buf = vim.api.nvim_get_current_buf()

		-- When the term command is done, reset the cursor.
		vim.api.nvim_create_autocmd("TermClose", {
			callback = function()
				vim.api.nvim_win_set_cursor(preview_win, cursor)
				vim.api.nvim_clear_autocmds({ group = glow_augroup_preview })
			end,
			group = glow_augroup_preview,
			buffer = preview_buf,
		})

		vim.api.nvim_set_current_win(markdown_win)
	end

	preview()

	local cleanup = function()
		vim.api.nvim_win_close(preview_win, true)
		vim.api.nvim_clear_autocmds({ group = glow_augroup })
	end

	-- Create the autocommand to reload glow
	vim.api.nvim_create_autocmd("BufWritePost", {
		callback = preview,
		group = glow_augroup,
		buffer = markdown_buf,
	})

	-- Cleanup on close
	-- FIXME: this prevents closing the markdown buffer, needs to close twice
	vim.api.nvim_create_autocmd("BufLeave", {
		callback = cleanup,
		group = glow_augroup,
		buffer = markdown_buf,
	})

	command("GlowStop", cleanup, opts)
end, opts)
