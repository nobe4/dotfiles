-- Inspired by from https://neovim.io/doc/user/luvref.html#luv-timer-handle

local M = function(delay_in_ms, callback)
	local timer = vim.uv.new_timer()
	timer:start(delay_in_ms, 0, function()
		timer:stop()
		timer:close()
		callback()
	end)
	return timer
end

return M
