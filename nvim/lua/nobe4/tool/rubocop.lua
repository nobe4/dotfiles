-- Computes the rubocop command
local command_cache = ""
local command = function()
	if command_cache == "" then
		if vim.fn.executable("./bin/rubocop") == 1 then
			command_cache = "./bin/rubocop"
		else
			command_cache = "rubocop"
		end
	end

	return command_cache
end

return {
	command = command,
}
